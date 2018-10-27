Param(
    [string] $PathToInstallFile = "install.json",
    [bool] $Overwrite = $true
)

function PSObjectToDictionary {
    Param( $psobject )

    $dict = @{}

    $psobject.psobject.properties | ForEach-object {
        $dict.Add($_.Name, $_.Value)
    }

    return $dict
}

$install = Get-Content -Path $PathToInstallFile -Raw | ConvertFrom-Json

foreach ( $theme in $install.themes ) {
    $themeName = $theme.name
    $remoteTheme = Get-SPOTheme -Name $themeName

    # ConvertFrom-Json returns a PSObject, which is not compatible with the Add-SPOTheme cmdlet. No biggie, we'll just convert it to a Dictionary.
    $palette = PSObjectToDictionary -psobject $theme.palette
    
    if( ($null -eq $remoteTheme ) -or ( $null -ne $remoteTheme -and $Overwrite -eq $true ) ) {
        Add-SPOTheme -Name $theme.name -Palette $palette -IsInverted $theme.isInverted
        Write-Host "Theme '$themeName' has been updated."
    } else {
        write-host "Theme '$themeName' already exists, but the overwrite parameter has been set to false. No action taken."
    }
}
