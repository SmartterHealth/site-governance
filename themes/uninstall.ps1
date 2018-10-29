Param(
    [string] $PathToInstallFile = "install.json",
    [bool] $Overwrite = $true
)

# Include utility functions
. ../lib/util.ps1

# Read in our installation settings from the .json file.
$install = Get-Content -Path $PathToInstallFile -Raw | ConvertFrom-Json

# For each theme in the .json file, uninstall it.
foreach ( $theme in $install.themes ) {
    $themeName = $theme.name

    $remoteTheme = Get-SPOTheme | Where-Object { $_.Name -eq $themeName }

    if( $remoteTheme -ne $null ) {
        Remove-SPOTheme -Identity $themeName
        Write-Host "Theme '$themeName' removed."
    } else {
        write-host "Theme '$themeName' not found. No action taken."
    }    
}