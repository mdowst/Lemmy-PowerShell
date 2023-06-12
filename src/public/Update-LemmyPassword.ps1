Function Update-LemmyPassword {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER NewPassword

	.PARAMETER NewPasswordVerify

	.PARAMETER OldPassword


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: changePassword
    #>
    param(
		[string]$NewPassword,
		[string]$NewPasswordVerify,
		[string]$OldPassword
)
   
    	$RequestParameters = @{
		new_password = $NewPassword
		new_password_verify = $NewPasswordVerify
		old_password = $OldPassword
}

    Invoke-LemmyRestMethod -Uri '/user/change_password' -Method 'PUT' -RequestParameters $RequestParameters
}
