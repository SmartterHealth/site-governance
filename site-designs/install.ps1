Param(
    [string] $PathToInstallFile = "install.json",
    [bool] $Overwrite = $true
)

$install = Get-Content -Path $PathToInstallFile -Raw | ConvertFrom-Json

foreach ( $siteDesign in $install.siteScripts ) {
    $title = $siteDesign.title
    write-host $title
}
 