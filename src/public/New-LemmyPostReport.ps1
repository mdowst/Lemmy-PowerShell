Function New-LemmyPostReport {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER PostId

	.PARAMETER Reason


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: createPostReport
    #>
    param(
		[int]$PostId,
		[string]$Reason
)
   
    	$RequestParameters = @{
		post_id = $PostId
		reason = $Reason
}

    Invoke-LemmyRestMethod -Uri '/post/report' -Method 'POST' -RequestParameters $RequestParameters
}
