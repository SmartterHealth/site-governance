. ./lib/util.ps1

$connected = Check-SPOConnection

if ($connected -eq $false ) {
    write-host "Please connect to SharePoint Online using Connect-SPOService before running this script."
    exit
}

Set-Location -Path ./themes 
./install.ps1

Set-Location -Path ../site-scripts
./install.ps1

Set-Location -Path ../site-designs
./install.ps1

Set-Location -Path ../
write-host "Done!"
