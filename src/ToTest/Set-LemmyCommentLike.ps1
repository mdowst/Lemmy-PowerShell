Function Set-LemmyCommentLike {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER CommentId

	.PARAMETER Score


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: likeComment
    #>
    param(
        [int]$CommentId,
        [int]$Score
    )
   
    $RequestParameters = @{
        comment_id = $CommentId
        score      = $Score
    }

    Invoke-LemmyRestMethod -Uri '/comment/like' -Method 'POST' -RequestParameters $RequestParameters
}
