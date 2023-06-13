Function Remove-LemmyPostDatabase {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER PostId

	.PARAMETER Reason


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: purgePost
    #>
    param(
		[int]$PostId,
		[string]$Reason
)
   
    	$RequestParameters = @{
		post_id = $PostId
		reason = $Reason
}

    Invoke-LemmyRestMethod -Uri '/admin/purge/post' -Method 'POST' -RequestParameters $RequestParameters
}
