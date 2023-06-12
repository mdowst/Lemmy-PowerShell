Function Get-LemmyUnreadCount {
    <#
    .SYNOPSIS
    Call Lemmy API

    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: getUnreadCount
    #>
    param()
   
    

    Invoke-LemmyRestMethod -Uri '/user/unread_count' -Method 'GET' 
}
