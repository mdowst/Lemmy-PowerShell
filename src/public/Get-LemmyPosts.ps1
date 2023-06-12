Function Get-LemmyPosts {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER CommunityId

	.PARAMETER CommunityName

	.PARAMETER Limit

	.PARAMETER Page

	.PARAMETER SavedOnly

	.PARAMETER Sort

	.PARAMETER Type


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: getPosts
    #>
    param(
		[int]$CommunityId,
		[string]$CommunityName,
		[int]$Limit,
		[int]$Page,
		[boolean]$SavedOnly,
				[ValidateSet('Active','Hot','MostComments','New','NewComments','Old','TopAll','TopDay','TopMonth','TopWeek','TopYear')]
		[string]$Sort,
				[ValidateSet('All','Community','Local','Subscribed')]
		[string]$Type
)
   
    	$RequestParameters = @{
		community_id = $CommunityId
		community_name = $CommunityName
		limit = $Limit
		page = $Page
		saved_only = $SavedOnly
		sort = $Sort
		type_ = $Type
}

    Invoke-LemmyRestMethod -Uri '/post/list' -Method 'GET' -RequestParameters $RequestParameters
}
