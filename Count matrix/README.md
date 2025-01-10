This folder contains the macros needed to create the count matrix in Excel from the read counts, since the original files are in separate txt format for each sample.

To do this, two Excel macros have been created.

-> Module1.bas (ImportTXT): With this macro you can import the 33 read_counts.txt files into an Excel workbook, indicating each sample in the name of the respective sheet from a selected folder.

-> Module2.bas (Count_matrix): This macro automates the consolidation of the read_counts scattered across several Excel sheets into a single sheet, facilitating the integration and analysis of the data.

After using these macros in an empty Excel sheet, we obtain the count_matrix file, which will be the starting point for performing the differential expression analysis.
