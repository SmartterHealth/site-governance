. ./lib/util.ps1

$connected = Check-SPOConnection

if ($connected -eq $false ) {
    write-host "Please connect to SharePoint Online using Connect-SPOService before running this script."
    exit
}

Set-Location -Path ./themes 
./uninstall.ps1

Set-Location -Path ../site-scripts
./uninstall.ps1

Set-Location -Path ../site-designs
./uninstall.ps1

Set-Location -Path ../
write-host "Done!"