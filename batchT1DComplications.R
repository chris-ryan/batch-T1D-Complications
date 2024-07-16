library(rms)

# Read in test data (the output is a data frame)
T1Dcomp_testdata<-read.csv("test-data.csv", header = TRUE)

# Import the risk models
DPN_mod<-readRDS("data/T1Dcomp_DPNmod_logit.rds")
DAN_mod<-readRDS("data/T1Dcomp_DANmod_logit.rds")
DRET_mod<-readRDS("data/T1Dcomp_DRETmod_logit.rds")
DNEP_mod<-readRDS("data/T1Dcomp_DNEPmod_logit.rds")

# Calculate and print the sum of each row
row_sums <- rowSums(T1Dcomp_testdata)
for (i in 1:nrow(T1Dcomp_testdata)) {
print(paste("id: ", T1Dcomp_testdata[i,1]))
  # predict the risk of each complication
  print(paste("Diabetic Peripheral Neuropathy risk: ",
        round(predict(DPN_mod,
                      newdata=T1Dcomp_testdata[i,],
                      na.action = na.pass,
                      type = "fitted")*100,4),
        "%"
  ))
  print(paste("Diabetic Autonomic Neuropathy risk: ",
        round(predict(DAN_mod,
                      newdata=T1Dcomp_testdata[i,],
                      type = "fitted")*100,4),
        "%"
  ))
  print(paste("Diabetic Retinopathy risk: ",
              round(predict(DRET_mod,
                            newdata=data.frame(Dr_Age=T1Dcomp_testdata[i,2],
                                               Dx_Age=T1Dcomp_testdata[i,3],
                                               Dur=T1Dcomp_testdata[i,2]-T1Dcomp_testdata[i,3],
                                               AvgA1c=T1Dcomp_testdata[i,5],
                                               avg.Systolic=T1Dcomp_testdata[i,4]),
                            type = "fitted")*100,4),
              "%"
  ))
  DNEP_result<-round(predict(DNEP_mod,
                             newdata=T1Dcomp_testdata[i,],
                             type = "fitted")*100,4)
  cat("Diabetic Nephropathy risk: ",DNEP_result,"%")
}
