library(rms)

# Read in test data (the output is a data frame)
T1Dcomp_testdata<-read.csv("test-data.csv", header = TRUE)

# Import the risk models
DPN_mod<-readRDS("Shiny App/T1D_Complications/data/T1Dcomp_DPNmod_logit.rds")
DAN_mod<-readRDS("Shiny App/T1D_Complications/data/T1Dcomp_DANmod_logit.rds")
DRET_mod<-readRDS("Shiny App/T1D_Complications/data/T1Dcomp_DRETmod_logit.rds")
DNEP_mod<-readRDS("Shiny App/T1D_Complications/data/T1Dcomp_DNEPmod_logit.rds")

# Calculate and print the sum of each row
row_sums <- rowSums(T1Dcomp_testdata)
for (i in 1:nrow(T1Dcomp_testdata)) {
  
  DPN_result<-round(predict(DPN_mod,newdata=T1Dcomp_testdata[i,],
    na.action = na.pass,
    type = "fitted")*100,4)

  DAN_result<-round(predict(DAN_mod,
    newdata=T1Dcomp_testdata[i,],
    type = "fitted")*100,4)

  DRET_result<-round(predict(DRET_mod,
    newdata=data.frame(Dr_Age=T1Dcomp_testdata[i,2],
    Dx_Age=T1Dcomp_testdata[i,3],
    Dur=T1Dcomp_testdata[i,2]-T1Dcomp_testdata[i,3],
    AvgA1c=T1Dcomp_testdata[i,5],
    avg.Systolic=T1Dcomp_testdata[i,4]),
    type = "fitted")*100,4)
  
  DNEP_result<-round(predict(DNEP_mod,
    newdata=T1Dcomp_testdata[i,],
    type = "fitted")*100,4)

  # Print the row id and risk model results out to the console
  cat("id: ", T1Dcomp_testdata[i,1], "\n")
  cat("Diabetic Peripheral Neuropathy risk: ",DPN_result,"% \n")
  cat("Diabetic Autonomic Neuropathy risk: ",DAN_result,"% \n")
  cat("Diabetic Retinopathy risk: ",DRET_result,"% \n")
  cat("Diabetic Nephropathy risk: ",DNEP_result,"% \n \n")

  # Print the results out to the csv file: output.csv
  cat(T1Dcomp_testdata[i,1], DPN_result, DAN_result, DRET_result, DNEP_result, file="output.csv", append=TRUE, sep=",", eol="\n")
}
