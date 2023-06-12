Function Remove-LemmyAdmin {
    <#
    .SYNOPSIS
    Call Lemmy API

    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: leaveAdmin
    #>
    param()
   
    

    Invoke-LemmyRestMethod -Uri '/user/leave_admin' -Method 'POST' 
}
