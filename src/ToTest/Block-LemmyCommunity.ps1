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
		[boolean]$Block,
		[int]$CommunityId
)
   
    	$RequestParameters = @{
		block = $Block
		community_id = $CommunityId
}

    Invoke-LemmyRestMethod -Uri '/community/block' -Method 'POST' -RequestParameters $RequestParameters
}
