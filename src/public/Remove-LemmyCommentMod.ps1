Function Remove-LemmyCommentMod {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER CommentId

	.PARAMETER Reason

	.PARAMETER Removed


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: removeComment
    #>
    param(
		[int]$CommentId,
		[string]$Reason,
		[boolean]$Removed
)
   
    	$RequestParameters = @{
		comment_id = $CommentId
		reason = $Reason
		removed = $Removed
}

    Invoke-LemmyRestMethod -Uri '/comment/remove' -Method 'POST' -RequestParameters $RequestParameters
}
