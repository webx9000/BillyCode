$Documents 	 = 	Get-ChildItem -Recurse "$ENV:USERPROFILE\Documents" | Measure-Object -property length -sum
$Downloads 	 = 	Get-ChildItem -Recurse "$ENV:USERPROFILE\Downloads" | Measure-Object -property length -sum
$Pictures	 = 	Get-ChildItem -Recurse "$ENV:USERPROFILE\Pictures" | Measure-Object -property length -sum
$Favorites	 = 	Get-ChildItem -Recurse "$ENV:USERPROFILE\Favorites" | Measure-Object -property length -sum

[int]$DataFilesize = ( ($Documents.SUM + $Pictures.Sum + $Downloads.sum + $Favorites.sum)   / 1GB )
    ### Establish the data type with an INT. 

Write-Host "Date Size: $DataFilesize"
Pause

Robocopy "$ENV:USERPROFILE\documents"  "$ENV:USERPROFILE\OneDrive - Eastern National\Documents" /mir /r:2 /w:3
Robocopy "$ENV:USERPROFILE\Downloads"  "$ENV:USERPROFILE\OneDrive - Eastern National\Downloads" /mir /r:2 /w:3
Robocopy "$ENV:USERPROFILE\Pitures"  "$ENV:USERPROFILE\OneDrive - Eastern National\Pictures" /mir /r:2 /w:3
Robocopy "$ENV:USERPROFILE\Favorites"  "$ENV:USERPROFILE\OneDrive - Eastern National\Favorites" /mir /r:2 /w:3