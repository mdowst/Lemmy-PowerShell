Function New-LemmyCommentReport {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER CommentId

	.PARAMETER Reason


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: createCommentReport
    #>
    param(
		[int]$CommentId,
		[string]$Reason
)
   
    	$RequestParameters = @{
		comment_id = $CommentId
		reason = $Reason
}

    Invoke-LemmyRestMethod -Uri '/comment/report' -Method 'POST' -RequestParameters $RequestParameters
}
