Function Remove-LemmyPostMod {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER PostId

	.PARAMETER Reason

	.PARAMETER Removed


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: removePost
    #>
    param(
		[int]$PostId,
		[string]$Reason,
		[boolean]$Removed
)
   
    	$RequestParameters = @{
		post_id = $PostId
		reason = $Reason
		removed = $Removed
}

    Invoke-LemmyRestMethod -Uri '/post/remove' -Method 'POST' -RequestParameters $RequestParameters
}
