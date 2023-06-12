Function Add-LemmyModToCommunity {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Added

	.PARAMETER CommunityId

	.PARAMETER PersonId


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: addModToCommunity
    #>
    param(
		[boolean]$Added,
		[int]$CommunityId,
		[int]$PersonId
)
   
    	$RequestParameters = @{
		added = $Added
		community_id = $CommunityId
		person_id = $PersonId
}

    Invoke-LemmyRestMethod -Uri '/community/mod' -Method 'POST' -RequestParameters $RequestParameters
}
