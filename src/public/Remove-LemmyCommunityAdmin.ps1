Function Remove-LemmyCommunityAdmin {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER CommunityId

	.PARAMETER Deleted


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: deleteCommunity
    #>
    param(
		[int]$CommunityId,
		[boolean]$Deleted
)
   
    	$RequestParameters = @{
		community_id = $CommunityId
		deleted = $Deleted
}

    Invoke-LemmyRestMethod -Uri '/community/delete' -Method 'POST' -RequestParameters $RequestParameters
}
