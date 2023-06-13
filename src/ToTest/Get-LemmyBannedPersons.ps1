Function Get-LemmyBannedPersons {
    <#
    .SYNOPSIS
    Call Lemmy API

    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: getBannedPersons
    #>
    param()
   
    

    Invoke-LemmyRestMethod -Uri '/user/banned' -Method 'GET' 
}
