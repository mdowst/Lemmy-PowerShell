Function Set-LemmyPostLike {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER PostId

	.PARAMETER Score


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: likePost
    #>
    param(
        [int]$PostId,
        [int]$Score
    )
   
    $RequestParameters = @{
        post_id = $PostId
        score   = $Score
    }

    Invoke-LemmyRestMethod -Uri '/post/like' -Method 'POST' -RequestParameters $RequestParameters
}
