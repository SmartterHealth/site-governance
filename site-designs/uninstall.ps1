Param(
    [string] $PathToInstallFile = "install.json",
    [bool] $Overwrite = $true
)

# Include utility functions
. ../lib/util.ps1

# Read in our installation settings from the .json file.
$install = Get-Content -Path $PathToInstallFile -Raw | ConvertFrom-Json

# For each site design in the .json file, uninstall it.
foreach ( $siteDesign in $install.siteDesigns ) {
    $title = $siteDesign.title
    $remoteSiteDesign = Get-SPOSiteDesign | Where-Object { $_.Title -eq $title }
    If ($remoteSiteDesign -ne $null ) {
        Remove-SPOSiteDesign -Identity $remoteSiteDesign.Id
        write-host "Site Design '$title' removed."
    } else {
        write-host "Site Design '$title' was not found in SharePoint Online. No action taken."
    }
}