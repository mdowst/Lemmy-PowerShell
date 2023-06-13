Function Set-LemmyFollowCommunity {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER CommunityId

	.PARAMETER Follow


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: followCommunity
    #>
    param(
		[int]$CommunityId,
		[boolean]$Follow
)
   
    	$RequestParameters = @{
		community_id = $CommunityId
		follow = $Follow
}

    Invoke-LemmyRestMethod -Uri '/community/follow' -Method 'POST' -RequestParameters $RequestParameters
}
