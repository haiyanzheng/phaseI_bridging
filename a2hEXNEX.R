rm(list=ls())

set.seed(684324)
library(R2OpenBUGS)

#----------------- rats and monkey data for escalation -------------------#
NstudyA = 5
MdoseA = 17
n.sp = 2
DoseA   = c( 0.1, 1,  6, 30,  1.5, 5, 10, 25,  1,  5, 10, 1, 30, 100, 10, 30, 100)
NtoxA   = c( 1,   1,  3,  4,  2,   2,  4,  5,  1,  3,  6, 1,  1,   2,  1,  3,   4)
NsubA   = c(10,  10, 10, 10, 10,  10, 10, 10, 15, 15, 15, 4,  4,   4, 10, 12,  12)
StudyA  = c( 1,   1,  1,  1,  2,   2,  2,  2,  3,  3,  3, 4,  4,   4,  5,  5,   5)
Species = c( 1,   1,  1,  1,  1,   1,  1,  1,  1,  1,  1, 2,  2,   2,  2,  2,   2)

Prior.mn.delta = c(-1.820, -1.127)
Prior.sd.delta = c( 0.323,  0.273)

n.sb = 2
MdoseH = 6
DoseRef = 5

Prior.mn.epsilon = rep(1, n.sb)
Prior.sd.epsilon = rep(0.255, n.sb)

wMix = matrix(c(0.2, 0.6, 0,   0.2,
                0.1, 0.5, 0.2, 0.2), ncol = n.sp+2, byrow = TRUE)

DoseH = c(0.1, 0.5, 1, 5, 10, 20)

NtoxH = matrix(c(0, 0, 0, 0, 0, 0,
                 0, 0, 0, 0, 0, 0), ncol = MdoseH, byrow = TRUE)

NsubH = matrix(c(0, 0, 0, 0, 0, 0,
                 0, 0, 0, 0, 0, 0), ncol = MdoseH, byrow = TRUE)


Prior.mH1 = c(-1.099, 1.98)
Prior.mH2 = c(0, 0.99)
Prior.mA1 = c(-1.099, 1.98)
Prior.mA2 = c(0, 0.99)

Prior.tau.HN = c(0.5, 0.25, 0.25, 0.125)
Prior.sigma.HN = c(1, 0.5)

Prior.rho = c(-1, 1)
Prior.kappa = c(-1, 1)

pTox.cut = c(0.16, 0.33)

# Nstudy*n.sp matrix
PInd = matrix(c(1, 0, 
                1, 0,  
                1, 0, 
                0, 1, 
                0, 1),
              ncol = n.sp, byrow = TRUE)

Prior.mw = c(-1.099, 0)
Prior.sw = c(2, 1)
Prior.corr = 0


data <- list("n.sp", "NstudyA", "MdoseA", "DoseA", "NtoxA", "NsubA", "StudyA", "Species", 
             "Prior.mn.delta", "Prior.sd.delta", "DoseRef", "PInd",
             "Prior.mw", "Prior.sw", "Prior.corr", 
             "Prior.mn.epsilon", "Prior.sd.epsilon", 
             "n.sb", "MdoseH", "DoseH", "NtoxH", "NsubH", 
             "Prior.mA1", "Prior.mA2", "Prior.mH1", "Prior.mH2", "Prior.tau.HN", 
             "Prior.sigma.HN", "Prior.rho", "Prior.kappa", "wMix", "pTox.cut")

inits <- function(){
  list(
    muA = c(-0.0142, -0.0919), muH = c(-0.0142, -0.0919),
    tauA = matrix(c(0.5, 0.5), ncol=2), tauH = matrix(c(0.5, 0.5), ncol=2),
    sigma = matrix(c(0.5, 0.5), ncol=2)
  )
}

parameters <- c("each", "pToxH")


MCMCSim <- bugs(data, inits, parameters, "a2hEXNEX.txt", codaPkg = F, 
                # OpenBUGS.pgm = "/opt/openbugs/bin/OpenBUGS",
                n.chains = 2, n.burnin = 3000, n.iter = 13000)

MCMCSim$summary

MCMCSim$mean$each

MCMCSim$mean$pToxH
