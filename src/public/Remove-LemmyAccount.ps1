Function Remove-LemmyAccount {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Password


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: deleteAccount
    #>
    param(
		[string]$Password
)
   
    	$RequestParameters = @{
		password = $Password
}

    Invoke-LemmyRestMethod -Uri '/user/delete_account' -Method 'POST' -RequestParameters $RequestParameters
}
