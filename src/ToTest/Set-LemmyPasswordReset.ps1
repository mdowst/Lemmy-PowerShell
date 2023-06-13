Function Set-LemmyPasswordReset {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Email


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: passwordReset
    #>
    param(
		[string]$Email
)
   
    	$RequestParameters = @{
		email = $Email
}

    Invoke-LemmyRestMethod -Uri '/user/password_reset' -Method 'POST' -RequestParameters $RequestParameters
}
