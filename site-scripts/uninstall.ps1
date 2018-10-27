Param(
    [string] $PathToInstallFile = "install.json",
    [bool] $Overwrite = $true
)

$install = Get-Content -Path $PathToInstallFile -Raw | ConvertFrom-Json

foreach ( $siteScript in $install.siteScripts ) {
    $title = $siteScript.title.Trim()
    $remoteScript = Get-SPOSiteScript | Where-Object { $_.Title -eq $title } | Select Id

    if ( $remoteScript -eq $null ) {
        write-host "Site Script '$title' not found. No action taken."
    } else {
        Remove-SPOSiteScript -Identity $remoteScript.Id
        write-host "Site Script '$title' removed"
    }
}