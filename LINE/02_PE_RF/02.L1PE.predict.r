#!/usr/bin/env Rscript

args = commandArgs(trailingOnly=TRUE)
set.seed(1)
masterpath<-args[1]
datpath<-args[2]
retro<-args[3]
library('randomForest')
library('PRROC')

### read the saved models ###
rf1.filename <- paste(as.character(masterpath),"/LINE/02_PE_RF/RFI_1.rds", sep="")
rf1 <- readRDS(rf1.filename)
rf2.filename <- paste(as.character(masterpath),"/LINE/02_PE_RF/RFI_2.rds", sep="")
rf2 <- readRDS(rf2.filename)
rf3.filename <- paste(as.character(masterpath),"/LINE/02_PE_RF/RFI_3.rds", sep="")
rf3 <- readRDS(rf3.filename)
rf4.filename <- paste(as.character(masterpath),"/LINE/02_PE_RF/RFI_4.rds", sep="")
rf4 <- readRDS(rf4.filename)
rf5.filename <- paste(as.character(masterpath),"/LINE/02_PE_RF/RFI_5.rds", sep="")
rf5 <- readRDS(rf5.filename)
rf6.filename <- paste(as.character(masterpath),"/LINE/02_PE_RF/RFI_6.rds", sep="")
rf6 <- readRDS(rf6.filename)
rf7.filename <- paste(as.character(masterpath),"/LINE/02_PE_RF/RFI_7.rds", sep="")
rf7 <- readRDS(rf7.filename)
rf8.filename <- paste(as.character(masterpath),"/LINE/02_PE_RF/RFI_8.rds", sep="")
rf8 <- readRDS(rf8.filename)

filename <- paste(as.character(datpath),"/list.txt", sep="")
subs <- read.table(filename, sep="\t", header=F)
for (i in 1:dim(subs)[1])
   {
    filename <- paste(as.character(datpath),"/",as.character(subs[i,1]),"/retro_v",as.character(retro),"_0/",as.character(subs[i,1]),".pe.LINE.matrix2", sep="")
    clone1 <- read.table(filename, sep="\t", header=T)
    filename <- paste(as.character(datpath),"/",as.character(subs[i,1]),"/retro_v",as.character(retro),"_1/",as.character(subs[i,1]),".pe.LINE.matrix2", sep="")
    clone2 <- read.table(filename, sep="\t", header=T)
    clone  <- rbind(clone1, clone2)
    subclone <- subset(clone, (clone[,7] == 1 | clone[,8] == 1) & ref == 0)
    subclone$gap <- subclone$gap/(abs(subclone$refpos1 - subclone$refpos2))

    test1 <- subset(subclone, !is.na(ACAG))
    nx1 <- test1[,c("seg", "map", "anchor_align", "anchor_len", "anchor_mm", "anchor_XS", "anchor_AS", "anchor_mapQ", "depth","map_len","short","end3","end5","direction", "refpos", "dist", "c1", "upstream", "ACAG")]
    ny1 <- test1$pos
    pred.RF1 <- predict(rf1,newdata=nx1,type='prob')[,2]
    accu1 <- mean((pred.RF1 >0.5) == ny1)
    sens1 <- sum(pred.RF1[ny1==1] >0.5) / sum(ny1 ==1)
    prec1 <- sum(pred.RF1[ny1==1] >0.5) / sum(pred.RF1 >0.5)
    F1 <- 2*sens1*prec1 / (sens1 + prec1)
    roc1 <- roc.curve(scores.class0 = pred.RF1[ny1==1], scores.class1 = pred.RF1[ny1==0], curve = T)
    pr1 <- pr.curve(scores.class0 = pred.RF1[ny1==1], scores.class1 = pred.RF1[ny1==0], curve = T)
    out1 <- c(accu1, sens1, prec1, F1, roc1$auc, pr1$auc.integral)
    filename <- paste(as.character(datpath),"/RF",as.character(retro),"/LINE/G1.", i, ".stats.txt", sep="")
    write(t(out1), file=filename, ncol=6)
    pred1 <- data.frame(cbind(as.character(test1$chr), test1$cord1, test1$cord2, as.character(test1$read), pred.RF1))
    filename <- paste(as.character(datpath),"/",as.character(subs[i,1]),"/retro_v",as.character(retro),"_1/LINE/",as.character(subs[i,1]),".pe.pred.G1.txt", sep="")
    write(t(pred1), file=filename, ncol=5, sep="\t")

    test2 <- subset(subclone, !is.na(TAG))
    nx2 <- test2[,c("seg", "map", "anchor_align", "anchor_len", "anchor_mm", "anchor_XS", "anchor_AS", "anchor_mapQ", "depth","map_len","short","end3","end5","direction", "refpos", "dist", "c1", "upstream", "TAG")]
    ny2 <- test2$pos
    pred.RF2 <- predict(rf2,newdata=nx2,type='prob')[,2]
    accu2 <- mean((pred.RF2 >0.5) == ny2)
    sens2 <- sum(pred.RF2[ny2==1] >0.5) / sum(ny2 ==1)
    prec2 <- sum(pred.RF2[ny2==1] >0.5) / sum(pred.RF2 >0.5)
    F2 <- 2*sens2*prec2 / (sens2 + prec2)
    roc2 <- roc.curve(scores.class0 = pred.RF2[ny2==1], scores.class1 = pred.RF2[ny2==0], curve = T)
    pr2 <- pr.curve(scores.class0 = pred.RF2[ny2==1], scores.class1 = pred.RF2[ny2==0], curve = T)
    out2 <- c(accu2, sens2, prec2, F2, roc2$auc, pr2$auc.integral)
    filename <- paste(as.character(datpath),"/RF",as.character(retro),"/LINE/G2.", i, ".stats.txt", sep="")
    write(t(out2), file=filename, ncol=6)
    pred2 <- data.frame(cbind(as.character(test2$chr), test2$cord1, test2$cord2, as.character(test2$read), pred.RF2))
    filename <- paste(as.character(datpath),"/",as.character(subs[i,1]),"/retro_v",as.character(retro),"_1/LINE/",as.character(subs[i,1]),".pe.pred.G2.txt", sep="")
    write(t(pred2), file=filename, ncol=5, sep="\t")

    test3 <- subset(subclone, is.na(TAG) & is.na(ACAG) & (ORF==1))
    nx3 <- test3[,c("seg", "map", "anchor_align", "anchor_len", "anchor_mm", "anchor_XS", "anchor_AS", "anchor_mapQ","depth","map_len","short","end3","end5","direction", "refpos", "dist", "c1", "upstream", "Xscore")]
    ny3 <- test3$pos
    pred.RF3 <- predict(rf3,newdata=nx3,type='prob')[,2]
    accu3 <- mean((pred.RF3 >0.5) == ny3)
    sens3 <- sum(pred.RF3[ny3==1] >0.5) / sum(ny3 ==1)
    prec3 <- sum(pred.RF3[ny3==1] >0.5) / sum(pred.RF3 >0.5)
    F3 <- 2*sens3*prec3 / (sens3 + prec3)
    roc3 <- roc.curve(scores.class0 = pred.RF3[ny3==1], scores.class1 = pred.RF3[ny3==0], curve = T)
    pr3 <- pr.curve(scores.class0 = pred.RF3[ny3==1], scores.class1 = pred.RF3[ny3==0], curve = T)
    out3 <- c(accu3, sens3, prec3, F3, roc3$auc, pr3$auc.integral)
    filename <- paste(as.character(datpath),"/RF",as.character(retro),"/LINE/G3.", i, ".stats.txt", sep="")
    write(t(out3), file=filename, ncol=6)
    pred3 <- data.frame(cbind(as.character(test3$chr), test3$cord1, test3$cord2, as.character(test3$read), pred.RF3))
    filename <- paste(as.character(datpath),"/",as.character(subs[i,1]),"/retro_v",as.character(retro),"_1/LINE/",as.character(subs[i,1]),".pe.pred.G3.txt", sep="")
    write(t(pred3), file=filename, ncol=5, sep="\t")

    test4 <- subset(subclone, is.na(TAG) & is.na(ACAG) & (ORF==0) & (refpos < 6015))
    nx4 <- test4[,c("seg", "map", "anchor_align", "anchor_len", "anchor_mm", "anchor_XS", "anchor_AS", "anchor_mapQ", "depth","map_len","short","end3","end5","direction", "refpos", "dist", "c1", "upstream")]
    ny4 <- test4$pos
    pred.RF4 <- predict(rf4,newdata=nx4,type='prob')[,2]
    accu4 <- mean((pred.RF4 >0.5) == ny4)
    sens4 <- sum(pred.RF4[ny4==1] >0.5) / sum(ny4 ==1)
    prec4 <- sum(pred.RF4[ny4==1] >0.5) / sum(pred.RF4 >0.5)
    F4 <- 2*sens4*prec4 / (sens4 + prec4)
    roc4 <- roc.curve(scores.class0 = pred.RF4[ny4==1], scores.class1 = pred.RF4[ny4==0], curve = T)
    pr4 <- pr.curve(scores.class0 = pred.RF4[ny4==1], scores.class1 = pred.RF4[ny4==0], curve = T)
    out4 <- c(accu4, sens4, prec4, F4, roc4$auc, pr4$auc.integral)
    filename <- paste(as.character(datpath),"/RF",as.character(retro),"/LINE/G4.", i, ".stats.txt", sep="")
    write(t(out4), file=filename, ncol=6)
    pred4 <- data.frame(cbind(as.character(test4$chr), test4$cord1, test4$cord2, as.character(test4$read), pred.RF4))
    filename <- paste(as.character(datpath),"/",as.character(subs[i,1]),"/retro_v",as.character(retro),"_1/LINE/",as.character(subs[i,1]),".pe.pred.G4.txt", sep="")
    write(t(pred4), file=filename, ncol=5, sep="\t")

    test5 <- subset(subclone, is.na(TAG) & is.na(ACAG) & !is.na(GC5389))
    nx5 <- test5[,c("seg", "map", "anchor_align", "anchor_len", "anchor_mm", "anchor_XS", "anchor_AS", "anchor_mapQ", "depth","map_len","short","end3","end5","direction", "refpos", "dist", "c1", "upstream", "GC5389")]
    ny5 <- test5$pos
    pred.RF5 <- predict(rf5,newdata=nx5,type='prob')[,2]
    accu5 <- mean((pred.RF5 >0.5) == ny5)
    sens5 <- sum(pred.RF5[ny5==1] >0.5) / sum(ny5 ==1)
    prec5 <- sum(pred.RF5[ny5==1] >0.5) / sum(pred.RF5 >0.5)
    F5 <- 2*sens5*prec5 / (sens5 + prec5)
    roc5 <- roc.curve(scores.class0 = pred.RF5[ny5==1], scores.class1 = pred.RF5[ny5==0], curve = T)
    pr5 <- pr.curve(scores.class0 = pred.RF5[ny5==1], scores.class1 = pred.RF5[ny5==0], curve = T)
    out5 <- c(accu5, sens5, prec5, F5, roc5$auc, pr5$auc.integral)
    filename <- paste(as.character(datpath),"/RF",as.character(retro),"/LINE/G5.", i, ".stats.txt", sep="")
    write(t(out5), file=filename, ncol=6)
    pred5 <- data.frame(cbind(as.character(test5$chr), test5$cord1, test5$cord2, as.character(test5$read), pred.RF5))
    filename <- paste(as.character(datpath),"/",as.character(subs[i,1]),"/retro_v",as.character(retro),"_1/LINE/",as.character(subs[i,1]),".pe.pred.G5.txt", sep="")
    write(t(pred5), file=filename, ncol=5, sep="\t")

    test6 <- subset(subclone, is.na(TAG) & is.na(ACAG) & !is.na(G5533))
    nx6 <- test6[,c("seg", "map", "anchor_align", "anchor_len", "anchor_mm", "anchor_XS", "anchor_AS", "anchor_mapQ","depth","map_len","short","end3","end5","direction", "refpos", "dist", "c1", "upstream", "G5533", "C5533")]
    ny6 <- test6$pos
    pred.RF6 <- predict(rf6,newdata=nx6,type='prob')[,2]
    accu6 <- mean((pred.RF6 >0.5) == ny6)
    sens6 <- sum(pred.RF6[ny6==1] >0.5) / sum(ny6 ==1)
    prec6 <- sum(pred.RF6[ny6==1] >0.5) / sum(pred.RF6 >0.5)
    F6 <- 2*sens6*prec6 / (sens6 + prec6)
    roc6 <- roc.curve(scores.class0 = pred.RF6[ny6==1], scores.class1 = pred.RF6[ny6==0], curve = T)
    pr6 <- pr.curve(scores.class0 = pred.RF6[ny6==1], scores.class1 = pred.RF6[ny6==0], curve = T)
    out6 <- c(accu6, sens6, prec6, F6, roc6$auc, pr6$auc.integral)
    filename <- paste(as.character(datpath),"/RF",as.character(retro),"/LINE/G6.", i, ".stats.txt", sep="")
    write(t(out6), file=filename, ncol=6)
    pred6 <- data.frame(cbind(as.character(test6$chr), test6$cord1, test6$cord2, as.character(test6$read), pred.RF6))
    filename <- paste(as.character(datpath),"/",as.character(subs[i,1]),"/retro_v",as.character(retro),"_1/LINE/",as.character(subs[i,1]),".pe.pred.G6.txt", sep="")
    write(t(pred6), file=filename, ncol=5, sep="\t")

    test7 <- subset(subclone, is.na(TAG) & is.na(ACAG) & !is.na(AT5710))
    nx7 <- test7[,c("seg", "map", "anchor_align", "anchor_len", "anchor_mm", "anchor_XS", "anchor_AS", "anchor_mapQ", "depth","map_len","short","end3","end5","direction", "refpos", "dist", "c1", "upstream", "AT5710")]
    ny7 <- test7$pos
    pred.RF7 <- predict(rf7,newdata=nx7,type='prob')[,2]
    accu7 <- mean((pred.RF7 >0.5) == ny7)
    sens7 <- sum(pred.RF7[ny7==1] >0.5) / sum(ny7 ==1)
    prec7 <- sum(pred.RF7[ny7==1] >0.5) / sum(pred.RF7 >0.5)
    F7 <- 2*sens7*prec7 / (sens7 + prec7)
    roc7 <- roc.curve(scores.class0 = pred.RF7[ny7==1], scores.class1 = pred.RF7[ny7==0], curve = T)
    pr7 <- pr.curve(scores.class0 = pred.RF7[ny7==1], scores.class1 = pred.RF7[ny7==0], curve = T)
    out7 <- c(accu7, sens7, prec7, F7, roc7$auc, pr7$auc.integral)
    filename <- paste(as.character(datpath),"/RF",as.character(retro),"/LINE/G7.", i, ".stats.txt", sep="")
    write(t(out7), file=filename, ncol=6)
    pred7 <- data.frame(cbind(as.character(test7$chr), test7$cord1, test7$cord2, as.character(test7$read), pred.RF7))
    filename <- paste(as.character(datpath),"/",as.character(subs[i,1]),"/retro_v",as.character(retro),"_1/LINE/",as.character(subs[i,1]),".pe.pred.G7.txt", sep="")
    write(t(pred7), file=filename, ncol=5, sep="\t")

    test8 <- subset(subclone, anchor_split==1)
    nx8 <- test8[,c("seg", "map", "anchor_align", "anchor_len", "anchor_mm", "anchor_direct", "anchor_insert", "anchor_seg", "anchor_map", "anchor_XS", "anchor_AS", "anchor_mapQ", "depth","map_len","short","end3","end5","direction", "refpos", "dist", "c1", "upstream")]
    ny8 <- test8$pos
    pred.RF8 <- predict(rf8,newdata=nx8,type='prob')[,2]
    accu8 <- mean((pred.RF8 >0.5) == ny8)
    sens8 <- sum(pred.RF8[ny8==1] >0.5) / sum(ny8 ==1)
    prec8 <- sum(pred.RF8[ny8==1] >0.5) / sum(pred.RF8 >0.5)
    F8 <- 2*sens8*prec8 / (sens8 + prec8)
    roc8 <- roc.curve(scores.class0 = pred.RF8[ny8==1], scores.class1 = pred.RF8[ny8==0], curve = T)
    pr8 <- pr.curve(scores.class0 = pred.RF8[ny8==1], scores.class1 = pred.RF8[ny8==0], curve = T)
    out8 <- c(accu8, sens8, prec8, F8, roc8$auc, pr8$auc.integral)
    filename <- paste(as.character(datpath),"/RF",as.character(retro),"/LINE/G8.", i, ".stats.txt", sep="")
    write(t(out8), file=filename, ncol=6)
    pred8 <- data.frame(cbind(as.character(test8$chr), test8$cord1, test8$cord2, as.character(test8$read), pred.RF8))
    filename <- paste(as.character(datpath),"/",as.character(subs[i,1]),"/retro_v",as.character(retro),"_1/LINE/",as.character(subs[i,1]),".pe.pred.G8.txt", sep="")
    write(t(pred8), file=filename, ncol=5, sep="\t")
   }
