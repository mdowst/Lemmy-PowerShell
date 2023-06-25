Function Remove-LemmyComment {
    <#
    .SYNOPSIS
    Use to remove a comment from a post in your community (Moderator permissions required)

	.PARAMETER CommentId
    The ID of the comment

	.PARAMETER Reason
    The reason for removal

    .EXAMPLE
    $post = Get-LemmyPost -CommunityName 'MyCommunity' -SearchString 'Hello Lemmy'
    $comment = Get-LemmyComments -PostId $post.post.id -SearchString 'A naughty comment'
    Remove-LemmyComment -CommentId $comment.comment.id

    Searches for a post with the title 'Hello Lemmy' in the community 'MyCommunity', then gets the comment with the text 'A naughty comment', then removes the comment.
    
    .NOTES
    Lemmy API class: removeComment
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [int]$CommentId,
        [Parameter(Mandatory = $false)]
        [string]$Reason
    )
   
    $RequestParameters = @{
        comment_id = $CommentId
        reason     = $Reason
        removed    = $true
    }

    Invoke-LemmyRestMethod -Uri '/comment/remove' -Method 'POST' -RequestParameters $RequestParameters
}
