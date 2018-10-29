Param(
    [string] $PathToInstallFile = "install.json",
    [bool] $Overwrite = $true
)

function Get-SPOSiteScriptIDs {
    Param($siteScriptTitles)

    $ids = @()
    
    ForEach ($siteScriptTitle in $siteScriptTitles) {
        $remoteScript = Get-SPOSiteScript | Where-Object { $_.Title -eq $siteScriptTitle } 
        if( $remoteScript -ne $null ) {
            $ids += $remoteScript.Id
        }        
    }

    return $ids
}

# Read in our installation settings from the .json file.
$install = Get-Content -Path $PathToInstallFile -Raw | ConvertFrom-Json

foreach ( $siteDesign in $install.siteDesigns ) {
    $title = $siteDesign.title

    # See if the siteDesign existed remotely
    $remoteSiteDesign = Get-SPOSiteDesign | Where-Object { $_.Title -eq $title }

    # Convert Site Script Titles to their IDs by looking them up
    $siteScriptIDs = Get-SPOSiteScriptIDs($siteDesign.siteScripts)

     # Make sure the user wants to overwrite the theme if it already existed.
     if ( $remoteSiteDesign -eq $null ) {
        Add-SPOSiteDesign -Title $title -Description $siteDesign.description -WebTemplate $siteDesign.webTemplate -SiteScripts $siteScriptIDs -IsDefault $siteDesign.isDefault
        write-host "Site Design '$title' added."
    } else {
        if ( $Overwrite -eq $true ) {
            Set-SPOSiteDesign -Identity $remoteSiteDesign.Id -Title $title -Description $siteDesign.description -WebTemplate $siteDesign.webTemplate -SiteScripts $siteScriptIDs -IsDefault $siteDesign.isDefault
            write-host "Site Design '$title' updated."
        } else {
            write-host "Site Design '$title' already exists, but the overwrite parameter has been set to false. No action taken."
        }
    }
}

 