Function Remove-LemmyCommentDatabase {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER CommentId

	.PARAMETER Reason


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: purgeComment
    #>
    param(
		[int]$CommentId,
		[string]$Reason
)
   
    	$RequestParameters = @{
		comment_id = $CommentId
		reason = $Reason
}

    Invoke-LemmyRestMethod -Uri '/admin/purge/comment' -Method 'POST' -RequestParameters $RequestParameters
}
