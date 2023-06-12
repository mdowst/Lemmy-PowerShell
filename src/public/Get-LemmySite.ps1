Function Get-LemmySite {
    <#
    .SYNOPSIS
    Call Lemmy API

    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: getSite
    #>
    param()
   
    

    Invoke-LemmyRestMethod -Uri '/site' -Method 'GET' 
}
