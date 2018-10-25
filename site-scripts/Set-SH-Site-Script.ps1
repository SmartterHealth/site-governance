$rawData = Get-Content './team-site.json' -Raw
$data = ConvertFrom-Json $rawData

$title = $data.title
$script = Get-SPOSiteScript | Where { $_.Title -eq $title }
$id = $null

if ( $script -eq $null ) {
    write-host "Site Script $title does not exist. Create it? (y/n)"

    $response = Read-Host

    if ($response -eq "y") {
        Add-SPOSiteScript -Title $title -Content $rawData
    }

} else {
    write-host "Site Script $title exists. Update it? (y/n)"

    $response = Read-Host

    if ($response -eq "y") {
        Set-SPOSiteScript -Identity $script.Id -Title $title -Content $rawData
    }
}


