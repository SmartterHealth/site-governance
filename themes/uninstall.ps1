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
    Remove-SPOTheme -Identity $theme.name
}