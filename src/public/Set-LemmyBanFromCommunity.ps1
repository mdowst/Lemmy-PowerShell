Function Set-LemmyBanFromCommunity {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Ban

	.PARAMETER CommunityId

	.PARAMETER Expires

	.PARAMETER PersonId

	.PARAMETER Reason

	.PARAMETER RemoveData


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: banFromCommunity
    #>
    param(
		[boolean]$Ban,
		[int]$CommunityId,
		[int]$Expires,
		[int]$PersonId,
		[string]$Reason,
		[boolean]$RemoveData
)
   
    	$RequestParameters = @{
		ban = $Ban
		community_id = $CommunityId
		expires = $Expires
		person_id = $PersonId
		reason = $Reason
		remove_data = $RemoveData
}

    Invoke-LemmyRestMethod -Uri '/community/ban_user' -Method 'POST' -RequestParameters $RequestParameters
}
