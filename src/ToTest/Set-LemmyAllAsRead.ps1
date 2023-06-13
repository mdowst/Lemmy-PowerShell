Function Set-LemmyAllAsRead {
    <#
    .SYNOPSIS
    Call Lemmy API

    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: markAllAsRead
    #>
    param()
   
    

    Invoke-LemmyRestMethod -Uri '/user/mark_all_as_read' -Method 'POST' 
}
