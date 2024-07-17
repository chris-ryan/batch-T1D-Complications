# batch-T1D-Complications
An R script to apply pmtran5884's Type 1 Diabetes risk prediction tool to a batch of inputs

**To use:**
1.	Download and extract the full T1D_Complication code repository at https://github.com/pmtran5884/T1D_Complications/tree/main (Click on the Code button then select Download ZIP)
2.	Download this repo (https://github.com/chris-ryan/batch-T1D-Complications) and extract the files into the root of the T1D_Complications directory.
3.	Edit batch-data.csv to contain the data you wish to analyse.
(NOTE: Do not change the column order or header labels).

… in R Studio
4.	From the top menu, select File > Open File, browse to the T1D_Complications folder and open batchT1DComplications.R
5.	From the top menu, select Session > Set Working Directory > To Source File Location (or right-click the file name tab at the top of the Source pane to select this option)
6.	Click the Source button to run the Script. The risks will be outputted into the Console pane and into the file output.csv.
NOTE: If you run the script successfully multiple times, you’ll need to clear out the data rows from output.csv as it will append the results to the file.

