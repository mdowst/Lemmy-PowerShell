Function Get-LemmyBannedPersons {
    <#
    .SYNOPSIS
    Get all the banned user for your instance

    .EXAMPLE
    Get-LemmyBannedPersons
    
    .NOTES
    Lemmy API class: getBannedPersons
    #>
    [CmdletBinding()]
    param()
   
    Invoke-LemmyRestMethod -Uri ('/user/banned?auth=' + $Global:__LemmyInstance.auth) -Method 'GET'
}
