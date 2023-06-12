Function Get-LemmyPersonDetails {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER CommunityId

	.PARAMETER Limit

	.PARAMETER Page

	.PARAMETER PersonId

	.PARAMETER SavedOnly

	.PARAMETER Sort

	.PARAMETER Username


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: getPersonDetails
    #>
    param(
		[int]$CommunityId,
		[int]$Limit,
		[int]$Page,
		[int]$PersonId,
		[boolean]$SavedOnly,
				[ValidateSet('Active','Hot','MostComments','New','NewComments','Old','TopAll','TopDay','TopMonth','TopWeek','TopYear')]
		[string]$Sort,
		[string]$Username
)
   
    	$RequestParameters = @{
		community_id = $CommunityId
		limit = $Limit
		page = $Page
		person_id = $PersonId
		saved_only = $SavedOnly
		sort = $Sort
		username = $Username
}

    Invoke-LemmyRestMethod -Uri '/user' -Method 'GET' -RequestParameters $RequestParameters
}
