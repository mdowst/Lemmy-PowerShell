Function Move-LemmyCommunity {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER CommunityId

	.PARAMETER PersonId


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: transferCommunity
    #>
    param(
		[int]$CommunityId,
		[int]$PersonId
)
   
    	$RequestParameters = @{
		community_id = $CommunityId
		person_id = $PersonId
}

    Invoke-LemmyRestMethod -Uri '/community/transfer' -Method 'POST' -RequestParameters $RequestParameters
}
