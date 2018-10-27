Set-Location -Path ./themes 
./install.ps1

Set-Location -Path ../site-scripts
./install.ps1

Set-Location -Path ../site-designs
./install.ps1

Set-Location -Path ../
write-host "Done!"
