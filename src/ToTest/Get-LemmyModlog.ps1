Function Get-LemmyModlog {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER CommunityId

	.PARAMETER Limit

	.PARAMETER ModPersonId

	.PARAMETER OtherPersonId

	.PARAMETER Page

	.PARAMETER Type


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: getModlog
    #>
    param(
		[int]$CommunityId,
		[int]$Limit,
		[int]$ModPersonId,
		[int]$OtherPersonId,
		[int]$Page,
		[ValidateSet('AdminPurgeComment','AdminPurgeCommunity','AdminPurgePerson','AdminPurgePost','All','ModAdd','ModAddCommunity','ModBan','ModBanFromCommunity','ModFeaturePost','ModHideCommunity','ModLockPost','ModRemoveComment','ModRemoveCommunity','ModRemovePost','ModTransferCommunity')]
		[string]$Type
)
   
    	$RequestParameters = @{
		community_id = $CommunityId
		limit = $Limit
		mod_person_id = $ModPersonId
		other_person_id = $OtherPersonId
		page = $Page
		type_ = $Type
}

    Invoke-LemmyRestMethod -Uri '/modlog' -Method 'GET' -RequestParameters $RequestParameters
}
