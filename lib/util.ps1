function Check-SPOConnection {
    try
    {
        Get-MsolDomain -ErrorAction Stop > $null
    }
    catch 
    {
        write-host "You are not connected to SharePoint Online. Would you like to connect now? (y/n)"
        $result = Read-Host

        if ( $result -eq "y" ) {
            Connect-SPOService

            return $true
        } else {
            return $false
        }
    }
}

function PSObjectToDictionary {
    Param( $psobject )

    $dict = @{}

    $psobject.psobject.properties | ForEach-object {
        $dict.Add($_.Name, $_.Value)
    }

    return $dict
}