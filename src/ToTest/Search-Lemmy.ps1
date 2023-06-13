Function Search-Lemmy {
	<#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER CommunityId

	.PARAMETER CommunityName

	.PARAMETER CreatorId

	.PARAMETER Limit

	.PARAMETER ListingType

	.PARAMETER Page

	.PARAMETER Q

	.PARAMETER Sort

	.PARAMETER Type


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: search
    #>
	param(
		[int]$CommunityId,
		[string]$CommunityName,
		[int]$CreatorId,
		[int]$Limit,
		[ValidateSet('All', 'Community', 'Local', 'Subscribed')]
		[string]$ListingType,
		[int]$Page,
		[string]$Q,
		[ValidateSet('Active', 'Hot', 'MostComments', 'New', 'NewComments', 'Old', 'TopAll', 'TopDay', 'TopMonth', 'TopWeek', 'TopYear')]
		[string]$Sort,
		[ValidateSet('All', 'Comments', 'Communities', 'Posts', 'Url', 'Users')]
		[string]$Type
	)
   
	$RequestParameters = @{
		community_id   = $CommunityId
		community_name = $CommunityName
		creator_id     = $CreatorId
		limit          = $Limit
		listing_type   = $ListingType
		page           = $Page
		q              = $Q
		sort           = $Sort
		type_          = $Type
	}

	$query = $RequestParameters.GetEnumerator() | ForEach-Object{
		if($_.Value){
			"$($_.key)=$($_.Value)"
		}
	}

	Invoke-LemmyRestMethod -Uri ('/search?' + ($query -join('&'))) -Method 'GET' -RequestParameters $RequestParameters
}
