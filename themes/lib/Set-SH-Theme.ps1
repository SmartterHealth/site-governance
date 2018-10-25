

$theme = Get-SPOTheme | Where { $_.Name -eq $themeName }
$verb = ""

if ( $theme -eq $null ) {
    $verb = "added"
    write-host "Theme $themeName does not exist. Create it? (y/n)"
} else {
    $verb = "updated"
    write-host "Theme $themeName does exists. Update it? (y/n)"
}

$response = Read-host

if( $response -eq "y" ) {
    # See the following article on this command.
    # https://docs.microsoft.com/en-us/powershell/module/sharepoint-online/Add-SPOTheme?view=sharepoint-ps
    $theme = Add-SPOTheme -Name $themeName -Palette $palette -IsInverted $true        
    write-host "Theme $themeName has been $verb!"
} else {
    write-host "No action taken. Have a nice day!"
}
