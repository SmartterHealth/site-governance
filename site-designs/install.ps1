Param (
    [string] $PathToConfigFile,
    [bool] $IsDefault = $false
)

Write-Host $PathToConfigFile

$rawData = Get-Content $PathToConfigFile -Raw | ConvertFrom-Json

$title = $rawData.title
$webTemplate = $rawData.webTemplate
$siteScripts = $rawData.siteScripts
$description = $rawData.description
$actionTaken = $null

$siteDesign = Get-SPOSiteDesign | Where-Object { $_.Title -eq $title}

if ( $null -eq $siteDesign ) {
    write-host "Site Design $title does not exist. Create it? (y/n)"
    $response = read-host

    if ($response -eq "y") {
        $actionTaken = "added"
        $siteDesign = ( Add-SPOSiteDesign -Title $title -WebTemplate $webTemplate -SiteScripts $siteScripts -Description $description -IsDefault $true )
    }
    
} else {
    write-host "Site Design $title exists. Update it? (y/n)"

    $response = read-host

    if ($response -eq "y") {
        $actionTaken = "updated"
        Set-SPOSiteDesign -Identity $siteDesign.Id -Title $title -WebTemplate $webTemplate -SiteScripts $siteScripts -Description $description -IsDefault $true
    }   
}

if( $null -eq $actionTaken ) {
    write-host "No action taken."
} else {

    $id = $siteDesign.Id

    Write-Host "Site Design '$title' has been $actionTaken."
    Write-Host "TIP: You can run Invoke-SPSiteDesign -Identity $Id -WebUrl <your-spo-site-url-here> to update an existing site with the new design."
}