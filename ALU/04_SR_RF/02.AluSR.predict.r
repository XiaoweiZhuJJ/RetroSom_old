#!/usr/bin/env Rscript

args = commandArgs(trailingOnly=TRUE)
set.seed(1)
masterpath<-args[1]
datpath<-args[2]
retro<-args[3]
library('randomForest')
library('PRROC')

### read the saved models ###
rf1.filename <- paste(as.character(masterpath),"/ALU/04_SR_RF/RFIV.rds", sep="")
rf1 <- readRDS(rf1.filename)

filename <- paste(as.character(datpath),"/list.txt", sep="")
subs <- read.table(filename, sep="\t", header=F)
for (i in 1:dim(subs)[1])
   {
    filename <- paste(as.character(datpath),"/",as.character(subs[i,1]),"/retro_v",as.character(retro),"_0/",as.character(subs[i,1]),".sr.ALU.matrix.pAT", sep="")
    clone1 <- read.table(filename, sep="\t", header=T)
    filename <- paste(as.character(datpath),"/",as.character(subs[i,1]),"/retro_v",as.character(retro),"_1/",as.character(subs[i,1]),".sr.ALU.matrix.pAT", sep="")
    clone2 <- read.table(filename, sep="\t", header=T)
    clone  <- rbind(clone1, clone2)
    subclone <- subset(clone, (clone[,7] == 1 | clone[,8] == 1) & ref == 0)
    subclone$gap <- subclone$gap/(abs(subclone$refpos1 - subclone$refpos2))

    test1 <- subclone
    nx1 <- test1[,c("seg", "map", "depth","map_size", "map_ratio", "end3", "end5","direction", "refpos", "dist", "A_pair", "A_insert", "A_mm", "A_MapQ", "A_AS", "A_XS")]
    ny1 <- test1$pos
    pred.RF1 <- predict(rf1,newdata=nx1,type='prob')[,2]
    accu1 <- mean((pred.RF1 >0.5) == ny1)
    sens1 <- sum(pred.RF1[ny1==1] >0.5) / sum(ny1 ==1)
    prec1 <- sum(pred.RF1[ny1==1] >0.5) / sum(pred.RF1 >0.5)
    F1 <- 2*sens1*prec1 / (sens1 + prec1)
    roc1 <- roc.curve(scores.class0 = pred.RF1[ny1==1], scores.class1 = pred.RF1[ny1==0], curve = T)
    pr1 <- pr.curve(scores.class0 = pred.RF1[ny1==1], scores.class1 = pred.RF1[ny1==0], curve = T)
    out1 <- c(accu1, sens1, prec1, F1, roc1$auc, pr1$auc.integral)
    filename <- paste(as.character(datpath),"/RF",as.character(retro),"/ALU/T1.", i, ".stats.txt", sep="")
    write(t(out1), file=filename, ncol=6)
    pred1 <- data.frame(cbind(as.character(test1$chr), test1$cord1, test1$cord2, as.character(test1$read), pred.RF1))
    filename <- paste(as.character(datpath),"/",as.character(subs[i,1]),"/retro_v",as.character(retro),"_1/ALU/",as.character(subs[i,1]),".sr.pred.T1.txt", sep="")
    write(t(pred1), file=filename, ncol=5, sep="\t")
   }
