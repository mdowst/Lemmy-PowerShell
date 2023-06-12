Function Get-LemmyCaptcha {
    <#
    .SYNOPSIS
    Call Lemmy API

    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: getCaptcha
    #>
    param()
   
    

    Invoke-LemmyRestMethod -Uri '/user/get_captcha' -Method 'GET' 
}
