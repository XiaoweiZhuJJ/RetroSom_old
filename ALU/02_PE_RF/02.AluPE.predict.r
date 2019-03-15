#!/usr/bin/env Rscript

args = commandArgs(trailingOnly=TRUE)
set.seed(1)
masterpath<-args[1]
datpath<-args[2]
retro<-args[3]
library('randomForest')
library('PRROC')

### read the saved models ###
rf1.filename <- paste(as.character(masterpath),"/ALU/02_PE_RF/RFIII_1.rds", sep="")
rf1 <- readRDS(rf1.filename)
rf2.filename <- paste(as.character(masterpath),"/ALU/02_PE_RF/RFIII_2.rds", sep="")
rf2 <- readRDS(rf2.filename)

filename <- paste(as.character(datpath),"/list.txt", sep="")
subs <- read.table(filename, sep="\t", header=F)
for (i in 1:dim(subs)[1])
   {
    filename <- paste(as.character(datpath),"/",as.character(subs[i,1]),"/retro_v",as.character(retro),"_1/",as.character(subs[i,1]),".pe.ALU.matrix.pAT", sep="")
    clone1 <- read.table(filename, sep="\t", header=T)
    filename <- paste(as.character(datpath),"/",as.character(subs[i,1]),"/retro_v",as.character(retro),"_0/",as.character(subs[i,1]),".pe.ALU.matrix.pAT", sep="")
    clone2 <- read.table(filename, sep="\t", header=T)
    clone <- rbind(clone1, clone2)
    subclone <- subset(clone, (clone[,7] == 1 | clone[,8] == 1) & ref == 0)
    subclone$gap <- subclone$gap/(abs(subclone$refpos1 - subclone$refpos2))

    test1 <- subset(subclone, anchor_split==1)
    nx1 <- test1[,c("seg", "map", "anchor_align", "anchor_len", "anchor_mm", "anchor_direct", "anchor_insert", "anchor_seg", "anchor_map", "anchor_XS", "anchor_AS", "anchor_mapQ", "depth","map_len","end3", "end5", "trans2","direction", "refpos", "dist", "c1", "upstream")]
    ny1 <- test1$pos
    pred.RF1 <- predict(rf1,newdata=nx1,type='prob')[,2]
    accu1 <- mean((pred.RF1 >0.5) == ny1)
    sens1 <- sum(pred.RF1[ny1==1] >0.5) / sum(ny1 ==1)
    prec1 <- sum(pred.RF1[ny1==1] >0.5) / sum(pred.RF1 >0.5)
    F1 <- 2*sens1*prec1 / (sens1 + prec1)
    roc1 <- roc.curve(scores.class0 = pred.RF1[ny1==1], scores.class1 = pred.RF1[ny1==0], curve = T)
    pr1 <- pr.curve(scores.class0 = pred.RF1[ny1==1], scores.class1 = pred.RF1[ny1==0], curve = T)
    out1 <- c(accu1, sens1, prec1, F1, roc1$auc, pr1$auc.integral)
    filename <- paste(as.character(datpath),"/RF",as.character(retro),"/ALU/A1.", i, ".stats.txt", sep="")
    write(t(out1), file=filename, ncol=6)
    pred1 <- data.frame(cbind(as.character(test1$chr), test1$cord1, test1$cord2, as.character(test1$read), pred.RF1))
    filename <- paste(as.character(datpath),"/",as.character(subs[i,1]),"/retro_v",as.character(retro),"_1/ALU/",as.character(subs[i,1]),".pe.pred.A1.txt", sep="")
    write(t(pred1), file=filename, ncol=5, sep="\t")

    test2 <- subset(subclone, anchor_split==0)
    nx2 <- test2[,c("seg", "map", "anchor_align", "anchor_len", "anchor_mm", "anchor_XS", "anchor_AS", "anchor_mapQ", "depth","map_len","end3", "end5", "trans2","direction", "refpos", "dist", "c1", "upstream")]
    ny2 <- test2$pos
    pred.RF2 <- predict(rf2,newdata=nx2,type='prob')[,2]
    accu2 <- mean((pred.RF2 >0.5) == ny2)
    sens2 <- sum(pred.RF2[ny2==1] >0.5) / sum(ny2 ==1)
    prec2 <- sum(pred.RF2[ny2==1] >0.5) / sum(pred.RF2 >0.5)
    F2 <- 2*sens2*prec2 / (sens2 + prec2)
    roc2 <- roc.curve(scores.class0 = pred.RF2[ny2==1], scores.class1 = pred.RF2[ny2==0], curve = T)
    pr2 <- pr.curve(scores.class0 = pred.RF2[ny2==1], scores.class1 = pred.RF2[ny2==0], curve = T)
    out2 <- c(accu2, sens2, prec2, F2, roc2$auc, pr2$auc.integral)
    filename <- paste(as.character(datpath),"/RF",as.character(retro),"/ALU/A2.", i, ".stats.txt", sep="")
    write(t(out2), file=filename, ncol=6)
    pred2 <- data.frame(cbind(as.character(test2$chr), test2$cord1, test2$cord2, as.character(test2$read), pred.RF2))
    filename <- paste(as.character(datpath),"/",as.character(subs[i,1]),"/retro_v",as.character(retro),"_1/ALU/",as.character(subs[i,1]),".pe.pred.A2.txt", sep="")
    write(t(pred2), file=filename, ncol=5, sep="\t")
   }


