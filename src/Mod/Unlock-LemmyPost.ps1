Function Unlock-LemmyPost {
    <#
    .SYNOPSIS
    Use to unlock a post from your community (Moderator permissions required)

	.PARAMETER PostId
    The ID of the post

    .EXAMPLE
    $post = Get-LemmyPost -CommunityName 'MyCommunity' -SearchString 'Post to unlock'
    Lock-LemmyPost -PostId $post.post.id

    Searches for a post with the 'Post to unlock' in the community 'MyCommunity' then unlocks the post
    
    .NOTES
    Lemmy API class: lockPost
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [int]$PostId
    )
   
    $RequestParameters = @{
        locked  = $false
        post_id = $PostId
    }

    Invoke-LemmyRestMethod -Uri '/post/lock' -Method 'POST' -RequestParameters $RequestParameters
}
