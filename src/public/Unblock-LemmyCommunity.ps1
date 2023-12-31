Function Block-LemmyCommunity {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Block

	.PARAMETER CommunityId


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: blockCommunity
    #>
    param(
        [int]$CommunityId
    )
   
    $RequestParameters = @{
        block        = $false
        community_id = $CommunityId
    }

    Invoke-LemmyRestMethod -Uri '/community/block' -Method 'POST' -RequestParameters $RequestParameters
}
