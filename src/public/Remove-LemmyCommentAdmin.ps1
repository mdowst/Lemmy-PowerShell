Function Remove-LemmyCommentAdmin {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER CommentId

	.PARAMETER Deleted


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: deleteComment
    #>
    param(
		[int]$CommentId,
		[boolean]$Deleted
)
   
    	$RequestParameters = @{
		comment_id = $CommentId
		deleted = $Deleted
}

    Invoke-LemmyRestMethod -Uri '/comment/delete' -Method 'POST' -RequestParameters $RequestParameters
}
