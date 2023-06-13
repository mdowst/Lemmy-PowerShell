Function Set-LemmyPasswordChange {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Password

	.PARAMETER PasswordVerify

	.PARAMETER Token


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: passwordChange
    #>
    param(
		[string]$Password,
		[string]$PasswordVerify,
		[string]$Token
)
   
    	$RequestParameters = @{
		password = $Password
		password_verify = $PasswordVerify
		token = $Token
}

    Invoke-LemmyRestMethod -Uri '/user/password_change' -Method 'POST' -RequestParameters $RequestParameters
}
