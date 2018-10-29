Param(
    [string] $PathToInstallFile = "install.json",
    [bool] $Overwrite = $true
)

# Include utility functions
. ../lib/util.ps1

# Read in our installation settings from the .json file.
$install = Get-Content -Path $PathToInstallFile -Raw | ConvertFrom-Json

# For each theme in the .json file, install it.
foreach ( $theme in $install.themes ) {
    $themeName = $theme.name
    $remoteTheme = Get-SPOTheme -Name $themeName

    # ConvertFrom-Json returns a PSObject, which is not compatible with the Add-SPOTheme cmdlet. No biggie, we'll just convert it to a Dictionary.
    $palette = PSObjectToDictionary -psobject $theme.palette
    
    # Make sure the user wants to overwrite the theme if it already existed.
    if( ($null -eq $remoteTheme ) -or ( $null -ne $remoteTheme -and $Overwrite -eq $true ) ) {
        Add-SPOTheme -Name $theme.name -Palette $palette -IsInverted $theme.isInverted
        Write-Host "Theme '$themeName' has been updated."
    } else {
        write-host "Theme '$themeName' already exists, but the overwrite parameter has been set to false. No action taken."
    }
}
