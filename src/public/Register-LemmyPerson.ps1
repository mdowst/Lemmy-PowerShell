Function Register-LemmyPerson {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Answer

	.PARAMETER CaptchaAnswer

	.PARAMETER CaptchaUuid

	.PARAMETER Email

	.PARAMETER Honeypot

	.PARAMETER Password

	.PARAMETER PasswordVerify

	.PARAMETER ShowNsfw

	.PARAMETER Username


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: register
    #>
    param(
		[string]$Answer,
		[string]$CaptchaAnswer,
		[string]$CaptchaUuid,
		[string]$Email,
		[string]$Honeypot,
		[string]$Password,
		[string]$PasswordVerify,
		[boolean]$ShowNsfw,
		[string]$Username
)
   
    	$RequestParameters = @{
		answer = $Answer
		captcha_answer = $CaptchaAnswer
		captcha_uuid = $CaptchaUuid
		email = $Email
		honeypot = $Honeypot
		password = $Password
		password_verify = $PasswordVerify
		show_nsfw = $ShowNsfw
		username = $Username
}

    Invoke-LemmyRestMethod -Uri '/user/register' -Method 'POST' -RequestParameters $RequestParameters
}
