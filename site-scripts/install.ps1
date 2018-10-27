Param(
    [string] $PathToInstallFile = "install.json",
    [bool] $Overwrite = $true
)

$install = Get-Content -Path $PathToInstallFile -Raw | ConvertFrom-Json

foreach ( $siteScript in $install.siteScripts ) {
    $title = $siteScript.title
    $scriptJson = Get-Content -Path $siteScript.path -Raw

    $remoteScript = Get-SPOSiteScript | Where-Object { $_.Title -eq $title }

    if ( $remoteScript -eq $null ) {
        Add-SPOSiteScript -Title $title -Content $scriptJson
        write-host "Site Script '$title' added."
    } else {
        if ( $Overwrite -eq $true ) {
            Set-SPOSiteScript -Identity $remoteScript.id -Title $title -Content $scriptJson
            write-host "Site Script '$title' updated."
        } else {
            write-host "Site Script '$title' already exists, but the overwrite parameter has been set to false. No action taken."
        }
    }
}