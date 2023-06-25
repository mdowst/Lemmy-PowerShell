Function Remove-LemmyPost {
    <#
    .SYNOPSIS
    Use to remove a post from your community (Moderator permissions required)

	.PARAMETER PostId
    The ID of the post

	.PARAMETER Reason
    The reason for removal

    .EXAMPLE
    $post = Get-LemmyPost -CommunityName 'MyCommunity' -SearchString 'Hello Lemmy'
    Remove-LemmyPost -PostId $post.post.id -Reason 'breaking rule 1'

    Searches for a post with the title 'Hello Lemmy' in the community 'MyCommunity' then removed the post
    
    .NOTES
    Lemmy API class: removePost
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [int]$PostId,
        [Parameter(Mandatory = $false)]
        [string]$Reason
    )
   
    $RequestParameters = @{
        post_id = $PostId
        reason  = $Reason
        removed = $true
    }

    Invoke-LemmyRestMethod -Uri '/post/remove' -Method 'POST' -RequestParameters $RequestParameters
}
