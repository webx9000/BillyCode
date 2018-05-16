$rootpath = 'HKCR:\Drive\shell'
$regpath = 'HKCR:\Drive\shell\diskcleanup'
$commandpath = 'HKCR:\Drive\shell\diskcleanup\Command'
$psdrive = New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT

Write-Host 'This script adds the Disk Cleanup tool to the Jump Menu when you Right Click any Drive' -ForegroundColor Green
$readhost = Read-Host 'Continue Y (Yes) or N (No)'

Switch ($readhost) 
{
Y
    {
        $psdrive
        New-Item -path $rootpath -Name diskcleanup
        Set-ItemProperty -Path $regpath '(Default)' 'Disk Cleanup'
        New-Item -Path $regpath -Name Command 
        Set-ItemProperty -Path $commandpath '(Default)' 'cleanmgr.exe /d %1'
        Remove-PSDrive HKCR

        $testpath = Test-Path -Path $regpath
        If ($testpath -ne $testpath)
        {
            Write-Host 'Registry Key failed to create. Contact Will' -ForegroundColor Red
        }

        Else
        {
            Write-Host 'Registery Key created. Enjoy' -ForegroundColor Green
        }

    }
}

Switch ($readhost) {
N
    {
    Write-Host 'No action taken. Registry was not modified' -ForegroundColor Magenta
    Pause
    }
}


