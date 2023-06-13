Function Set-LemmyEmailVerification {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Token


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: verifyEmail
    #>
    param(
		[string]$Token
)
   
    	$RequestParameters = @{
		token = $Token
}

    Invoke-LemmyRestMethod -Uri '/user/verify_email' -Method 'POST' -RequestParameters $RequestParameters
}
