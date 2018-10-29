Param(
    [string] $PathToInstallFile = "install.json",
    [bool] $Overwrite = $true
)

# Include utility functions
. ../lib/util.ps1

# Read in our installation settings from the .json file.
$install = Get-Content -Path $PathToInstallFile -Raw | ConvertFrom-Json

# For each siteScript in the .json file, install it.
foreach ( $siteScript in $install.siteScripts ) {
    $title = $siteScript.title
    $scriptJson = Get-Content -Path $siteScript.path -Raw

    # See if the script existed remotely
    $remoteScript = Get-SPOSiteScript | Where-Object { $_.Title -eq $title }

    # Make sure the user wants to overwrite the theme if it already existed.
    if ( $remoteScript -eq $null ) {
        $result = Add-SPOSiteScript -Title $title -Content $scriptJson
        write-host "Site Script '$title' added."
    } else {
        if ( $Overwrite -eq $true ) {
            $result = Set-SPOSiteScript -Identity $remoteScript.id -Title $title -Content $scriptJson
            write-host "Site Script '$title' updated."
        } else {
            write-host "Site Script '$title' already exists, but the overwrite parameter has been set to false. No action taken."
        }
    }
}