# Sprint_Results

US Sprint Canoe and Kayak Results for the LastPlanet Canoe Kayak results app.  https://lastplanet.shinyapps.io/Times/

## To update results

1. Click the + to add a new file. To add a new directory for a new regatta, make the file something like `new regatta 2024/README.md` and add some info about what is in the folder and who added the files.
2. Then upload the original regatta results files into the directory as a record.
4. Copy one of the csv files in the `Scrapped Data Files` directory to use as a template. You can download a raw files on to your computer.
5. Give the file a short but distinctive name. See other files for examples.
6. Fill in results. Results can be partial. Only some paddlers or only some events. Add "partial" to file name if results are partial.
7. Enter the name in the results exactly as used in the official results. So if name in results "Blow, Joe" for "Joseph Blow" then enter "Blow, Joe" in the results csv.
8. When done, upload the file to `Scrapped Data Files` directory. Later you can edit the file directory on GitHub.

## Update the paddlers

1. Open the `Scrapped Data Files/nameresolver.csv` file and check that any paddlers added in the new results also appear in this file. If the paddler was racing in 2019 they should already be here. Decide on the 'official name' of the paddler and use that in the name column. Add a new row with each alternate name that appears in the results. So `name=Joseph Blow` and `alt.name=Blow, Joe`.
2. Open the `Scrapped Data Files/paddlers` directory and add any paddlers in the new results that are missing. This can be partial and having a paddler appear multiple places is fine. This show use the official name (so Joseph Blow). You can use NA for unknown information but having the birth year is very helpful. You can add a new file if you want or add names to existing file.
 
 
