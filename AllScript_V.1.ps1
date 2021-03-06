import-Module ActiveDirectory

$AdminCredentials = Get-Credential "easternnational\enadmin"

While($choice -ne 'exit')
{

Write-Host "Will's Super Awesome-o-Script-o-Matic" -foregroundcolor "Green"
Write-Host ""
Write-Host "Created: 12/6/2017 by William Singer" -foregroundcolor "Green"
Write-Host "Version 1.0"
Write-Host ""
Write-Host ""
Write-Host "About this Scipt:" 
Write-Host "This Script combines different scipts for Active Directory" 
Write-Host "It uses basic Powershell commands for interacting with AD Accounts"
Write-Host ""
Write-Host ""
Write-Host "What's New:" -foregroundcolor "Green"
Write-Host ""
Write-Host "- Changed the Name of the script to something more appropriate" -foregroundcolor "Green"
Write-Host "- Create AD User" -foregroundcolor "Green"
Write-Host "- Delete AD Account" -foregroundcolor "Green"
Write-Host "- A bit more formating" -foregroundcolor "Green"
Write-Host "- Script now Loops. No need to close it" -foregroundcolor "Green"
Write-Host "- Spell checked :-P" -foregroundcolor "Green"
Write-Host ""
Write-Host "Up Coming features:"
Write-Host ""
Write-Host "- Log every action into and outfile"
Write-Host "- Generate a report for each run of the script"
Write-Host "  Some day I'll add this feature"
Write-Host "- Want this script to do more? Have an idea?" 
Write-Host "  Bring me a cup of coffee and we'll talk"
Write-Host ""
Write-Host ""
$choice = Write-Host "Choose the form of your distructor. Type Exit to Quit"
Write-Host ""
Write-Host "1: Unlock the account"
Write-Host ""
Write-Host "2: Password Reset"
Write-Host ""
Write-Host "3: Display All AD"
Write-Host ""
Write-Host "4: Disable Account"
Write-Host ""
Write-Host "5: Add User to an AD Group"
Write-Host ""
Write-Host "6: Create new user"
Write-Host ""
Write-Host "7: Enable AD account"
Write-Host ""
Write-Host "8: Remove User from AD Group"
Write-Host ""
Write-Host "9: Remove AD User"
Write-Host ""
Write-Host "10: Documentation"
Write-Host ""
Write-Host "11: First Name Lookup"

$choice = Read-Host


######################################################################################################################################################
############################### Choice 1 #############################################################################################################
########################## Unlock User account #######################################################################################################
######################################################################################################################################################

    if ($choice -eq '1')
    {
    CLS
    ## Get the Username 
    Write-Host ""
    Write-Host $choice ": Unlock AD Account" -foregroundcolor "Green"
    Write-Host ""
    $username1=Read-Host "Enter the Username"
    ###
    $lockStatus = Get-ADUser $username1 -properties * | Select-Object Lock
    ###
    ###
    Write-Host ""
    Write-Host $username1
    Write-Host ""
        If(dsquery user -samid $username1)
            {
                Write-Host ""
                Write-Host "User Account Found" -foregroundcolor "Green"
                Write-Host ""
            }

        Else
            {
                Write-Host ""
                Write-Host "User Account Not Found" -foregroundcolor "Red"
                Read-Host -Prompt “Press Enter to continue”
                
            }
        

        If($lockedout.lockedOut)   
            {
                Write-Host "Account is locked..." -Foregroundcolor "Red"
            }

        else 
            {
                Write-Host "Account is not locked" -foregroundcolor "Green"
            }
    
    ## Assign the lockedout status command to the $lockedout variable
    $lockedout = Get-ADUser $username1 -properties * | Select-Object LockedOut
    ## Check the username in AD
    $lockedout
    ##If the account is locked...
    If($lockedout.lockedOut)
                ##Unlock the Account    
         {
             Write-Host "Account is locked..." -Foregroundcolor "Red"
             Write-Host ""
             Write-Host "Unlocking Now" -foregroundcolor "Green"   
             Write-Host ""
             Search-ADAccount -LockedOut -Credential $AdminCredentials| Unlock-ADAccount 
        
             Write-Host "When the Light is Green, The trap is clean. Account is unlocked" -Foregroundcolor "Green"
         }
    ## If account is not locked   
    Else  
        {
            Write-Host "Account is not locked. No action taken. Have a nice day!" -foregroundcolor "Green" 
            Write-Host ""  
            Write-Host "Support your National Parks!" -foregroundcolor "Green"
        }
        
      Read-Host -Prompt “Press Enter to continue.”
      CLS
      
    }

    ###################################################################################################################################################
    ############################# Choice 2 ############################################################################################################
    ###################### Password Reset #############################################################################################################
    ###################################################################################################################################################

    if ($choice -eq '2')
    {
    CLS
        ## Get the Username to be uses everywhere in the whole script
    Write-Host ""
    Write-Host $choice ": Reset AD Password" -foregroundcolor "Green"
    Write-Host ""
        $username2=Read-Host "Enter the Username"
        Write-Host ""
        ###
        $lockStatus = Get-ADUser $username2 -properties * | Select-Object Lock
        ###
        ###
        If(dsquery user -samid $username2)
            {
                Write-Host ""
                Write-Host "User Account Found" -foregroundcolor "Green"
                Write-Host ""
            }

        Else
            {
                Write-Host ""
                Write-Host "User Account Not Found" -foregroundcolor "Red"
                Write-Host ""
                Read-Host -Prompt “Press Enter to continue.”
            }
        

        If($lockedout.lockedOut)   
            {
                Write-Host ""
                Write-Host "Account is locked..." -Foregroundcolor "Red"
                Write-Host ""
            }

        else 
            {
                Write-Host ""
                Write-Host "Account is not locked" -foregroundcolor "Green"
                Write-Host ""
            }



    ## Get the New Password
    Write-Host ""
    $newpassword=Read-Host "Enter New Password" -AsSecureString
    Write-Host ""

    ## Set the new password
    Set-ADAccountPassword $username2 -NewPassword $newpassword -Credential $AdminCredentials 
    ## Confirm the password reset?

    $answer=Read-Host "Require the user to change their password at next logon? Yes(Y) or No(N)"


        ## Run the IF Statement to check if the condition has been met
        If($answer -eq 'y')
            {
            
                Set-aduser $username2 -changepasswordatlogon $true -Credential $AdminCredentials
            
                Write-Host ""
                Write-Host "Password for $username has been reset" -foregroundcolor "Green"
                Write-Host ""
                Write-Host "User must change the password at next login" -foregroundcolor "Green"
                Write-Host ""
            }

        ## If not...    
        Else
            {
                Write-Host ""
                Write-Host "Password for $username has been reset" -foregroundcolor "Green"
                Write-Host ""
                Write-Host "User DOES NOT have to change the password at next login" -foregroundcolor "Red"
            }

                Write-Host ""
                Read-Host -Prompt “Press Enter to continue.”
                CLS
    }


    ################################################################################################################################################
    ############################Choice 3############################################################################################################
    ##################### Display All AD Properties ################################################################################################
    ################################################################################################################################################

    if ($choice -eq '3')
    {
    CLS
   
    
    ## Get the Username to be uses everywhere in the whole script
    Write-Host ""
    Write-Host $choice ": Display Users AD Properties" -foregroundcolor "Green"
    Write-Host ""
    $username3=Read-Host "Enter the Username"
    
    $log = Get-Date
    
    ###
    $lockStatus = Get-ADUser $username3 -properties * | Select-Object Lock
    ###
    ###
    If(dsquery user -samid $username3)
        {
            Write-Host "User Account Found" -foregroundcolor "Green"
            
        }

    Else
        {
            Write-Host "User Account Not Found" -foregroundcolor "Red"
            
            Read-Host -Prompt “Press Enter to continue.”
            CLS
        }
        


    If($lockedout.lockedOut)   
        {
            Write-Host ""
            Write-Host "Account is locked..." -Foregroundcolor "Red"
            Write-Host ""
        }

    else 
        {
            Write-Host ""
            Write-Host "Account is not locked" -foregroundcolor "Green"
            Write-Host ""
        }
        
        Write-Host ""
        Write-Host $username3
        Write-Host ""
        Get-AdUser $username3 -Properties * | Format-List  Name, Enabled, Created, DisplayName, HomeDirectory, OfficePhone, Department, LastLogonDate, PasswordLastSet, PasswordExpired, LastBadPasswordAttempt, BadLogonCount, Title, City, EmailAddress 
        Write-Host $log | Out-File "C:\Users\williamsinger\Documents\Scripts\AllScript\AllScript Logs\DisplayADInfor.txt" -Append -Force
        Get-AdUser $username3 -Properties * | Format-List  Name, Enabled, Created, DisplayName, HomeDirectory, OfficePhone, Department, LastLogonDate, PasswordLastSet, PasswordExpired, LastBadPasswordAttempt, BadLogonCount, Title, City, EmailAddress | Out-File "C:\Users\williamsinger\Documents\Scripts\AllScript\AllScript Logs\DisplayADInfor.txt" -Append -Force
        Write-Host "A log file has been created for this. C:\Users\williamsinger\Documents\Scripts\AllScript\AllScript Logs\" -foregroundcolor "Green"
        Read-Host -Prompt “Press Enter to continue.”
        CLS
    }
        
    ###################################################################################################################################################
    ###########################Choice 4################################################################################################################
    #################Disable User Account #############################################################################################################
    ###################################################################################################################################################

    If ($choice -eq '4')
    {
    CLS
    ## Get the Username 
    Write-Host ""
    Write-Host $choice ": Disable AD Account" -foregroundcolor "Green" 
    Write-Host ""
    $username4=Read-Host "Enter the Username"
    ###
    $lockStatus = Get-ADUser $username4 -properties * | Select-Object Lock
    ###
    ###
        If(dsquery user -samid $username4)
            {
                Write-Host ""
                Write-Host "User Account Found" -foregroundcolor "Green"
                Write-Host ""
            
            }

        Else
            {
                Write-Host ""
                Write-Host "User Account Not Found" -foregroundcolor "Red"
                Write-Host ""
                Read-Host -Prompt “Press Enter to continue.”
                CLS
            }
        

        If($lockedout.lockedOut)   
            {
                Write-Host ""
                Write-Host "Account is locked..." -Foregroundcolor "Red"
                Write-Host ""
            }

        else 
            {
                Write-Host ""
                Write-Host "Account is not locked" -foregroundcolor "Green"
                Write-Host ""
            }
          
        Write-Host $username4
        Write-Host ""

        Disable-ADAccount $username4 -Credential $AdminCredentials
        Get-ADUser $username4 -Properties Enabled | Format-Table  Name, Enabled
        Write-Host "Account Has been Disabled"  
        Read-Host -Prompt “Press Enter to continue.”
        CLS
    }

    ######################################################################################################################################################
    ###########################Choice 5###################################################################################################################
    ################## Add User to an AD Group ###########################################################################################################
    ######################################################################################################################################################
    
    if ($choice -eq '5')
    {
    CLS
    ## Get the Username 
    Write-Host ""
    Write-Host $choice ": Add User to AD Group" -foregroundcolor "Green" 
    Write-Host ""
    $username5=Read-Host "Enter the Username"
    ###
    $lockStatus = Get-ADUser $username5 -properties * | Select-Object Lock
    ###
    ###
        If(dsquery user -samid $username5)
            {
                Write-Host ""
                Write-Host "User Account Found" -foregroundcolor "Green"
                Write-Host ""
            
            }

        Else
            {
                Write-Host ""
                Write-Host "User Account Not Found" -foregroundcolor "Red"
                Write-Host ""
                Read-Host -Prompt “Press Enter to continue.”
                CLS
            }
            
        

        If($lockedout.lockedOut)   
            {
                Write-Host ""
                Write-Host "Account is locked..." -Foregroundcolor "Red"
                Write-Host ""
            }

        else 
            {
                Write-Host ""
                Write-Host "Account is not locked" -foregroundcolor "Green"
                Write-Host ""
            }
    Write-Host $username5

        $groupname=Read-Host "Enter the group name you want to add"

        Add-ADGroupMember $groupname $username5 -Credential $AdminCredentials
    ## Add a way to verify that the group has been added. W/ an IF Statement
    if ($username5 -eq $groupname)
        {
            Write-Host "$username5 has been added to the $groupname group" -foregroundcolor "Green"
        }
    Else
        {
            Write-Host "$username was NOT added to $groupname group" -foregroundcolor "Red"
        }
        
            Read-Host -Prompt “Press Enter to continue.”
            CLS
    }
    
    ######################################################################################################################################################
    ##########################Choice 6####################################################################################################################
    ###Create AD User account
    ### Generate a report. Ouput report w/ date and username in the filename.
    ######################################################################################################################################################

    if ($choice -eq '6')
    {
    CLS
    
    Write-Host ""
    Write-Host $choice ": Create AD User" -foregroundcolor "Green" 
    Write-Host ""
    ### Get the new username
    $newuser = Read-Host "Enter the Username for the new Account"
        
        ### Create the account
        New-ADUser -Name "$newuser" -Credential $AdminCredentials    
        
        
        ### Set the Password for the new user
        $newpassword=Read-Host "Enter New Password" -AsSecureString

        ## Set the new password
        Set-ADAccountPassword $newuser -NewPassword $newpassword -Credential $AdminCredentials 

        $answer=Read-Host "Require the user to change their password at next logon? Yes(Y) or No(N):"

        If($answer -eq 'y')
            {
            
                Set-aduser $newuser -changepasswordatlogon $true -Credential $AdminCredentials
            
                Write-Host "Password for $username has been reset" -foregroundcolor "Green"
                Write-Host ""
                Write-Host "User must change the password at next login" -foregroundcolor "Green"
                Write-Host ""
            }
        Else
            {
                Write-Host "Password for $newuser has been reset" -foregroundcolor "Green"
                Write-Host ""
                Write-Host "User DOES NOT have to change the password at next login" -foregroundcolor "Red"
            }
            
        Enable-ADAccount -Identity $newuser -Credential $AdminCredentials
        Get-ADUser $newuser -Properties Enabled | Format-Table  Name, Enabled
       
    ## Create the Display Name
    
    $displayname = Read-Host "Enter the New Hires Name"
    Set-ADUser $newuser -DisplayName $displayname -Credential $AdminCredentials
    
    ## Home Drive
    
    ## Office Phone
    
    $officenumber = Read-Host "Enter the Office Number"
    Set-ADUser $newuser -OfficePhone $officenumber -Credential $AdminCredentials
    
    ## Department
    
    $department = Read-Host "Enter the Department"
    Set-ADUser $newuser -Department $department -Credential $AdminCredentials
    
    ## Title
    
    $title = Read-Host "Enter the Title for the new user"
    Set-ADUser $newuser -Title $title -Credential $AdminCredentials
    
    ## City
    
    $city = Read-Host "Enter the City"
    Set-ADUser $newuser -City $title -Credential $AdminCredentials
    
    ## EmailAddress
    
    $email = Read-Host "Enter the Email Address"
    Set-ADUser $newuser -EmailAddress $email -Credential $AdminCredentials
    
    
    ## Add memberships

        While (($groupname=Read-Host "Enter the group name you want to add. Press Q when done") -ne "Q")
            {
                ### Check AD that the group even exists
                
                Add-ADGroupMember $groupname $newuser -Credential $AdminCredentials
                
                Write-Host "$username has been added to the $groupname group" -foregroundcolor "Green"
                
        ## Add a way to verify that the group has been added. W/ an IF Statement
        
            }
            
            ##Create the Homedrive
            
    ## Print out a report of everything that was done
    Write-Host ""
    Write-Host "Report"
    Write-Host "Username: $newuser"
    Get-AdUser $newuser -Properties * | Format-List  Name, Enabled, Created, DisplayName, HomeDirectory, OfficePhone, Department, LastLogonDate, PasswordLastSet, PasswordExpired, LastBadPasswordAttempt, BadLogonCount, Title, City, EmailAddress 
    Get-ADPrincipalGroupMembership $newuser | select name
   Read-Host -Prompt “Press Enter to continue.”
   CLS
                      
    }

    ####################################################################################################################################################
    ########################Choice 7####################################################################################################################
    ################### Enable AD Account ##############################################################################################################
    ####################################################################################################################################################

    If ($choice -eq '7')
    {
    CLS
    ## Get the Username 
     Write-Host ""
    Write-Host $choice ": Display Users AD Membership" -Foregroundcolor "Green" 
    Write-Host ""
    $username7=Read-Host "Enter the Username"
    ###
    $lockStatus = Get-ADUser $username7 -properties * | Select-Object Lock
    ###
    ###
        If(dsquery user -samid $username7)
            {
                Write-Host ""
                Write-Host "User Account Found" -foregroundcolor "Green"
                Write-Host ""
            
            }

        Else
            {
                Write-Host ""
                Write-Host "User Account Not Found" -foregroundcolor "Red"
                Write-Host ""
                Read-Host -Prompt “Press Enter to continue.”
                CLS
            }
        

        If($lockedout.lockedOut)   
            {
                Write-Host "Account is locked..." -Foregroundcolor "Red"
            }

        else 
            {
                Write-Host "Account is not locked" -foregroundcolor "Green"
            }
    Write-Host $username7

        Enable-ADAccount $username7 -Credential $AdminCredentials
        Get-ADUser $username7 -Properties Enabled | Format-Table  Name, Enabled
        Write-Host "Account Has been Enabled"  
        Read-Host -Prompt “Press Enter to continue.” 
        CLS
    }

    ############################################################################################################################################################
    ################################# Choice 8 #################################################################################################################
    ############################# Remove AD Group ##############################################################################################################
    ############################################################################################################################################################
    
    if ($choice -eq '8')
    {
    CLS
    ## Get the Username 
    Write-Host ""
    Write-Host $choice ": Remove User from AD Group" -foregroundcolor "Green" 
    Write-Host ""
    $username8=Read-Host "Enter the Username"
    ###
    $lockStatus = Get-ADUser $username8 -properties * | Select-Object Lock
    ###
    ###
        If(dsquery user -samid $username8)
            {
                Write-Host ""
                Write-Host "User Account Found" -foregroundcolor "Green"
                Write-Host ""
            
            }

        Else
            {
                Write-Host ""
                Write-Host "User Account Not Found" -foregroundcolor "Red"
                Write-Host ""
                Read-Host -Prompt “Press Enter to continue.”
                CLS
            }
        

        If($lockedout.lockedOut)   
            {
                Write-Host ""
                Write-Host "Account is locked..." -Foregroundcolor "Red"
                Write-Host ""
            }

        else 
            {
                Write-Host ""
                Write-Host "Account is not locked" -foregroundcolor "Green"
                Write-Host ""
            }
    Write-Host $username8

        $groupname=Read-Host "Enter the group name you want to remove"

        Remove-ADGroupMember $groupname $username8 -Credential $AdminCredentials
    ## Add a way to verify that the group has been removed. W/ an IF Statement
    if ($username8 -ne $groupname)
        {
            Write-Host ""
            Write-Host "$username8 has been Removed to the $groupname group" -foregroundcolor "Green"
            Write-Host ""
        }
    Else
        {
            Write-Host ""
            Write-Host "$username8 was NOT added to $groupname group" -foregroundcolor "Red"
            Write-Host ""
        }
        Read-Host -Prompt “Press Enter to continue.”
        CLS
    }

    ############################################################################################################################################################
    ####################################### Remove AD Account ##################################################################################################
    ############################################################################################################################################################

    if ($choice -eq '9')
    {
    CLS
        $username9 = Read-Host "Enter the username you want to delete"
        If(dsquery user -samid $username9)
            {
                Write-Host "User Account Found" -foregroundcolor "Green"
            
            }

        Else
            {
                Write-Host "User Account Not Found" -foregroundcolor "Red"
                Read-Host -Prompt “Press Enter to exit”
                Exit
            }
            
        $deluser = Read-Host "ARE YOU SURE YOU WANT TO DELETE THIS ACCOUNT? Yes(y) No(n)"
        if ($deluser = 'y')
            { 
                Remove-ADUser $username9 -Credential $AdminCredentials
                Write-Host ""
                Write-Host $username9 "has been deleted"
                Write-Host ""
            }
        Else
            {
                Write-Host ""
                Write-Host $username9 "Was not deleted"
                Write-Host ""
            }
                Read-Host -Prompt “Press Enter to continue.”
                CLS
    }

    ############################################################################################################################################################
    ####################################### Documentation ######################################################################################################
    ############################################################################################################################################################

    if ($choice -eq '10')
    {
    CLS
        ##Pause the script
        Write-Host ""
        Write-Host ""
        Write-Host "Documentation"
        Write-Host ""
        Write-Host ""
        Get-Content C:\Users\williamsinger\Documents\Scripts\AllScript\AllScriptDoc.txt
        Write-Host ""
        Write-Host ""
        Read-Host -Prompt “Press Enter to Continue”
        Write-Host ""
        CLS
    }
    
    if($choice -eq 11)
    {
    
    CLS
    
    $firstname=Read-Host "Enter the first name"


    dsquery user -name $firstname* | dsget user -samid
    }
    
    Read-Host -Prompt “Press Enter to continue.”
    CLS    
}
