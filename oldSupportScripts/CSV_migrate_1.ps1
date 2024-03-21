# https://www.codetwo.com/admins-blog/how-to-split-csv-file-into-multiple-files-using-powershell/
# variable used to store the path of the source CSV file
$sourceCSV = <path of source CSV> ;

# variable used to advance the number of the row from which the export starts
$startrow = 0 ;

# counter used in names of resulting CSV files
$counter = 1 ;

# setting the while loop to continue as long as the value of the $startrow variable is smaller than the number of rows in your source CSV file
while ($startrow -lt <total number of rows in source CSV>)
{

# import of however many rows you want the resulting CSV to contain starting from the $startrow position and export of the imported content to a new file
Import-CSV $sourceCSV | select-object -skip $startrow -first <number of rows in resulting CSV> | Export-CSV "<resulting CSV filepath>$($counter).csv" -NoClobber;

# advancing the number of the row from which the export starts
$startrow += <number of rows in resulting CSV> ;

# incrementing the $counter variable
$counter++ ;

}