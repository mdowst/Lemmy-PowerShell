Function Remove-LemmyCommunityMod {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER CommunityId

	.PARAMETER Expires

	.PARAMETER Reason

	.PARAMETER Removed


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: removeCommunity
    #>
    param(
		[int]$CommunityId,
		[int]$Expires,
		[string]$Reason,
		[boolean]$Removed
)
   
    	$RequestParameters = @{
		community_id = $CommunityId
		expires = $Expires
		reason = $Reason
		removed = $Removed
}

    Invoke-LemmyRestMethod -Uri '/community/remove' -Method 'POST' -RequestParameters $RequestParameters
}
