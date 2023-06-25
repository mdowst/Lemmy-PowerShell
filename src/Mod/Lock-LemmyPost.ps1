Function Lock-LemmyPost {
    <#
    .SYNOPSIS
    Use to lock a post from your community (Moderator permissions required)

	.PARAMETER PostId
    The ID of the post

    .EXAMPLE
    $post = Get-LemmyPost -CommunityName 'MyCommunity' -SearchString 'Hello Lemmy'
    Lock-LemmyPost -PostId $post.post.id

    Searches for a post with the title 'Hello Lemmy' in the community 'MyCommunity' then locks the post
    
    .NOTES
    Lemmy API class: lockPost
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [int]$PostId
    )
   
    $RequestParameters = @{
        locked  = $true
        post_id = $PostId
    }

    Invoke-LemmyRestMethod -Uri '/post/lock' -Method 'POST' -RequestParameters $RequestParameters
}
