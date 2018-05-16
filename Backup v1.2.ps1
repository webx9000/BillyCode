Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force

# Import Assemblies
[void][reflection.assembly]::Load("System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")


#region | Global Variables
$date = Get-Date -Format MMMM.d.yyyy
$backupFolder = "User_Backup_" + "$date" 
#endregion


Write-Host "User Backup Script by William Singer"
Write-Host "This script will back up the Desktop, Documents, Pictures, Downloads, Favorites, and Music folders of the User currently logged in to a USB Thumb Drive" 
Write-Host "Included Reorts folder"
#Check for a USB Drive "http://stackoverflow.com/questions/10634396/how-do-i-get-the-drive-letter-of-a-usb-drive-in-powershell"
# Seach for USB
$UsbDisk = gwmi win32_diskdrive | ?{$_.interfacetype -eq "USB"} | %{gwmi -Query "ASSOCIATORS OF {Win32_DiskDrive.DeviceID=`"$($_.DeviceID.replace('\','\\'))`"} WHERE AssocClass = Win32_DiskDriveToDiskPartition"} |  %{gwmi -Query "ASSOCIATORS OF {Win32_DiskPartition.DeviceID=`"$($_.DeviceID)`"} WHERE AssocClass = Win32_LogicalDiskToPartition"} | %{$_.deviceid}

### If the A USB Drive isn't found...

if ( $UsbDisk -eq $null ) 
    { #IF_1

	[void][System.Windows.Forms.MessageBox]::Show("No USB Disk Found, Please Plug-In the USB Drive","USB Drive not found")
	
	} #IF_1

else
{ #Else_1
	
	$Usbfreedisk =  ((Get-WmiObject win32_logicalDisk  | where { $_.DeviceID -eq $usbdisk }).FreeSpace /1gb -as [INT])
	
	### Caclulate the total size of the Backup  C:\Username\Desktop | Documents | Downloads | Favorites | Links | Pictures | Music   
	
	$Desktop	 = 	Get-ChildItem -Recurse "$ENV:USERPROFILE\Desktop" | Measure-Object -property length -sum
	$Documents 	 = 	Get-ChildItem -Recurse "$ENV:USERPROFILE\Documents" | Measure-Object -property length -sum
	$Pictures	 = 	Get-ChildItem -Recurse "$ENV:USERPROFILE\Pictures" | Measure-Object -property length -sum
	$Downloads 	 = 	Get-ChildItem -Recurse "$ENV:USERPROFILE\Downloads" | Measure-Object -property length -sum
	$Favorites	 = 	Get-ChildItem -Recurse "$ENV:USERPROFILE\Favorites" | Measure-Object -property length -sum
	$Music		 =  Get-ChildItem -Recurse "$ENV:USERPROFILE\Music" | Measure-Object -property length -sum
	$reports     = Get-ChildItem -Recurse "C:\Program Files (x86)\Microsoft Retail Management System\Store Operations\Reports" | Mesure-Object -property length -sum

    ### Get the total size of the Backup
	[int]$DataFilesize = ( ($Desktop.sum + $Documents.SUM + $Pictures.Sum + $Downloads.sum + $Favorites.sum + $Music.sum )   / 1GB )
    ### Establish the data type with an INT. 
Write-Host "Backup Drive $UsbDisk"
Write-Host "$Usbfeedisk"
Write-Host "Backup Size: $DataFilesize GB"

Pause


	
	# Getting the available Drive space on the USB Drive
	if ( $Usbfreedisk -lt $DataFilesize ) 
        {  #IF_2
		
		[void][System.Windows.Forms.MessageBox]::Show("Your $usbDisk UDB Dive does not have enough available space, for backup we need $DatafileSize GB of free space.","Not Enough space")
		
		} #IF_2 
	
	else 
        { #Else_2 
		
		    $testfolder = Test-Path "$UsbDisk\$backupFolder" 
		
		if ( $testfolder -eq $true ) 
            { #IF_3 
		
		    [void][System.Windows.Forms.MessageBox]::Show("You already have backup folder $UsbDisk\$backupFolder Please rename it or delete it before running the backup ","Backup Folder Exists")
			
		    } #IF_3 
		
		else 
            { #Else_3
				
		        mkdir "$UsbDisk\$backupFolder"
		
		        # Start Copying Data
		
		        Robocopy "$ENV:USERPROFILE\desktop"  "$UsbDisk\$backupFolder\Desktop" /mir /r:2 /w:3
		        Robocopy "$ENV:USERPROFILE\documents"  "$UsbDisk\$backupFolder\documents" /mir /r:2 /w:3
		        Robocopy "$ENV:USERPROFILE\Pictures"  "$UsbDisk\$backupFolder\Pictures" /mir /r:2 /w:3
		        Robocopy "$ENV:USERPROFILE\Downloadss"  "$UsbDisk\$backupFolder\Downloads" /mir /r:2 /w:3
		        Robocopy "$ENV:USERPROFILE\Favorite"  "$UsbDisk\$backupFolder\Favorite" /mir /r:2 /w:3
		        Robocopy "$ENV:USERPROFILE\Music"  "$UsbDisk\$backupFolder\Music" /mir /r:2 /w:3
		        Robocopy "C:\Program Files (x86)\Microsoft Retail Management System\Store Operations\Reports" /mir /r:2 /w:3

		        Write-Host -ForegroundColor 'Green' "Backup Completed sucessfully"
                    Pause
		
		        #Open backup folder 
		        explorer "$UsbDisk\$backupFolder" 
			
			}#Else_3
	
		}#Else_2
	
} #Else_1
