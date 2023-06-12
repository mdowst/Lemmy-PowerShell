Function Set-LemmyCommentReplyAsRead {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER CommentReplyId

	.PARAMETER Read


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: markCommentReplyAsRead
    #>
    param(
		[int]$CommentReplyId,
		[boolean]$Read
)
   
    	$RequestParameters = @{
		comment_reply_id = $CommentReplyId
		read = $Read
}

    Invoke-LemmyRestMethod -Uri '/comment/mark_as_read' -Method 'POST' -RequestParameters $RequestParameters
}
