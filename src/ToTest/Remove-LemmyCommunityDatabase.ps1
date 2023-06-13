Function Remove-LemmyCommunityDatabase {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER CommunityId

	.PARAMETER Reason


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: purgeCommunity
    #>
    param(
		[int]$CommunityId,
		[string]$Reason
)
   
    	$RequestParameters = @{
		community_id = $CommunityId
		reason = $Reason
}

    Invoke-LemmyRestMethod -Uri '/admin/purge/community' -Method 'POST' -RequestParameters $RequestParameters
}
