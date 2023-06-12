Function Get-LemmyUnreadRegistrationApplicationCount {
    <#
    .SYNOPSIS
    Call Lemmy API

    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: getUnreadRegistrationApplicationCount
    #>
    param()
   
    

    Invoke-LemmyRestMethod -Uri '/admin/registration_application/count' -Method 'GET' 
}
