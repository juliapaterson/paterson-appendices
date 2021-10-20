library(here)
setwd(here())

#my_log <- file("get_descriptives_log.txt") # File name of output log
#sink(my_log, append = TRUE, type = "output") # Writing console output to log file
#sink(my_log, append = TRUE, type = "message")

d <- read.csv('julia_final.csv')

#filter included ids
d.included <- subset(d, includedIDs != 0)
summary(d.included$Age)
table(d.included$Sex.1.M.2.F.)

d.mu <- subset(d.included, Location.1.MU.2.UQ. !=2)
summary(d.mu$Age)
sd(d.mu$Age)
d.uq <- subset(d.included, Location.1.MU.2.UQ. !=1)
summary(d.uq$Age)
sd(d.uq$Age)

t.test(d.mu$Age, d.uq$Age)

d.adhd <- subset(d.included, Group !=2)
summary(d.adhd$Age)
sd(d.adhd$Age)
table(d.adhd$Sex.1.M.2.F.)

d.control <- subset(d.included, Group !=1)
summary(d.control$Age)
sd(d.control$Age)
table(d.control$Sex.1.M.2.F.)

#N2ciAmp_GA_ContraLeftTarget
#create scatterplot 
plot(d.included$Age, d.included$N2ciAmp_GA_ContraLeftTarget, pch=16)
#perform correlation test between the two vectors
cor.test(d.included$Age, d.included$N2ciAmp_GA_ContraLeftTarget)

#N2ciAmp_GA_ContraRightTarget
#create scatterplot 
plot(d.included$Age, d.included$N2ciAmp_GA_ContraRightTarget, pch=16)
#perform correlation test between the two vectors
cor.test(d.included$Age, d.included$N2ciAmp_GA_ContraRightTarget)

#N2ciAmp_GA_IpsiLeftTarget
#create scatterplot 
plot(d.included$Age, d.included$N2ciAmp_GA_IpsiLeftTarget, pch=16)
#perform correlation test between the two vectors
cor.test(d.included$Age, d.included$N2ciAmp_GA_IpsiLeftTarget)

#N2ciAmp_GA_IpsiRightTarget
#create scatterplot 
plot(d.included$Age, d.included$N2ciAmp_GA_IpsiRightTarget, pch=16)
#perform correlation test between the two vectors
cor.test(d.included$Age, d.included$N2ciAmp_GA_IpsiRightTarget)

#N2CLatency_LeftTarget
#create scatterplot 
plot(d.included$Age, d.included$N2CLatency_LeftTarget, pch=16)
#perform correlation test between the two vectors
cor.test(d.included$Age, d.included$N2CLatency_LeftTarget)

#N2CLatency_RightTarget
#create scatterplot 
plot(d.included$Age, d.included$N2CLatency_RightTarget, pch=16)
#perform correlation test between the two vectors
cor.test(d.included$Age, d.included$N2CLatency_RightTarget)

#N2iLatency_LeftTarget
#create scatterplot 
plot(d.included$Age, d.included$N2iLatency_LeftTarget, pch=16)
#perform correlation test between the two vectors
cor.test(d.included$Age, d.included$N2iLatency_LeftTarget)

#N2iLatency_RightTarget
#create scatterplot 
plot(d.included$Age, d.included$N2iLatency_RightTarget, pch=16)
#perform correlation test between the two vectors
cor.test(d.included$Age, d.included$N2iLatency_RightTarget)

#CPP_slope_LeftTarget
#create scatterplot 
plot(d.included$Age, d.included$CPP_slope_LeftTarget, pch=16)
#perform correlation test between the two vectors
cor.test(d.included$Age, d.included$CPP_slope_LeftTarget)

#CPP_slope_RightTarget
#create scatterplot 
plot(d.included$Age, d.included$CPP_slope_RightTarget, pch=16)
#perform correlation test between the two vectors
cor.test(d.included$Age, d.included$CPP_slope_RightTarget)

#StimlockedCPPOnset_LeftTarget
#create scatterplot 
plot(d.included$Age, d.included$StimlockedCPPOnset_LeftTarget, pch=16)
#perform correlation test between the two vectors
cor.test(d.included$Age, d.included$StimlockedCPPOnset_LeftTarget)

#StimlockedCPPOnset_RightTarget
#create scatterplot 
plot(d.included$Age, d.included$StimlockedCPPOnset_RightTarget, pch=16)
#perform correlation test between the two vectors
cor.test(d.included$Age, d.included$StimlockedCPPOnset_RightTarget)

#FrontalNeg_slope_Left
#create scatterplot 
plot(d.included$Age, d.included$FrontalNeg_slope_Left, pch=16)
#perform correlation test between the two vectors
cor.test(d.included$Age, d.included$FrontalNeg_slope_Left)

#FrontalNeg_slope_Right
#create scatterplot 
plot(d.included$Age, d.included$FrontalNeg_slope_Right, pch=16)
#perform correlation test between the two vectors
cor.test(d.included$Age, d.included$FrontalNeg_slope_Right)

#closeAllConnections() # Close connection to log file
