Function Get-LemmyPost {
	<#
	.SYNOPSIS
	Get a post by ID or search for a post

	.DESCRIPTION
	Get a post by ID or search for a post

	.PARAMETER Id
	The ID of the post

	.PARAMETER SearchString
	Specifies the text to search

	.PARAMETER StartTime
	Specifies the earliest time to return posts as a DateTime object. You can specify a string that can be converted to a valid DateTime. This gets posted that have a published time at or after the value that this parameter specifies.

	.PARAMETER EndTime
	Specifies the latest time to return posts as a DateTime object. You can specify a string that can be converted to a valid DateTime. This gets posted that have a published time at or before the value that this parameter specifies.

	.PARAMETER CommunityId
	The ID of the community

	.PARAMETER CommunityName
	The name of the community

	.PARAMETER ReturnLimit
	The total number of results to return

	.PARAMETER CreatorId
	The creator ID of the person who created the post

	.PARAMETER SavedOnly
	Set to true for saved posts

	.PARAMETER Sort
	Sort type 'Active', 'Hot', 'MostComments', 'New', 'NewComments', 'Old', 'TopAll', 'TopDay', 'TopMonth', 'TopWeek', 'TopYear'

	.PARAMETER Scope
	The scope in which to return posts from. Default is Local
	'All', 'Community', 'Local', or 'Subscribed'

	.EXAMPLE
	Get-LemmyPost -CommunityName 'MyCommunity' -SearchString 'Hello Lemmy'

	Searches for posts with the keywords 'Hello Lemmy' in the community name 'MyCommunity'

	.EXAMPLE
	Get-LemmyPost -ReturnLimit 50 -CommunityName 'AskLemmy'

	Gets the last 50 posts in the community named 'AskLemmy'

	.EXAMPLE
	Get-LemmyPost -StartTime (Get-Date).AddHours(-2) -CommunityId 1234

	Get all post from the last 2 hours from the community with the ID of 1234

	.EXAMPLE
	Get-LemmyPost -SearchString 'Music' -CommunityId 1234

	Searches for posts with the keyword 'Music' in the community with the ID of 1234

	.EXAMPLE
	Get-LemmyPost -SearchString 'Best mod tools' -ReturnLimit 150

	Searches the local instance for posts with the keywords 'Best mod tools' limit results to the last 150 posts

	.EXAMPLE
	Get-LemmyPost -SearchString 'Best mod tools' -Scope 'All' -ReturnLimit 150

	Searches the All instances for posts with the keywords 'Best mod tools' limit results to the last 150 posts
    
	
    .NOTES
    Lemmy API class: getPosts
#>
	[CmdletBinding(DefaultParameterSetName = 'Search')]
	param(
		[Parameter(Mandatory = $true, ParameterSetName = 'ID')]
		[int]$Id,

		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[Parameter(Mandatory = $false, ParameterSetName = 'DateRange')]
		[string]$SearchString,

		[Parameter(Mandatory = $true, ParameterSetName = 'DateRange')]
		[datetime]$StartTime,
		
		[Parameter(Mandatory = $false, ParameterSetName = 'DateRange')]
		[datetime]$EndTime = (Get-Date),

		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[Parameter(Mandatory = $false, ParameterSetName = 'DateRange')]
		[int]$CommunityId,
		
		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[Parameter(Mandatory = $false, ParameterSetName = 'DateRange')]
		[string]$CommunityName,

		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[int]$ReturnLimit = 50,
		
		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[int]$CreatorId,

		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[boolean]$SavedOnly,
		
		# Sort is always defaulted to New so the Date Range parameters will work
		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[ValidateSet('Active', 'Hot', 'MostComments', 'New', 'NewComments', 'Old', 'TopAll', 'TopDay', 'TopMonth', 'TopWeek', 'TopYear')]
		[string]$Sort = 'New',
		
		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[ValidateSet('All', 'Community', 'Local', 'Subscribed')]
		[string]$Scope = 'Local'
	)
	Test-LemmyConnection
	
	if ($PSCmdlet.ParameterSetName -eq 'ID') {
		$Posts = Invoke-LemmyRestMethod -Uri "/post" -Method 'GET' -QueryParameters @{id=$Id}
	}
	elseif ($PSBoundParameters['SearchString']) {
		# If sort is not supplied, set to 'TopAll'
		if (-not $PSBoundParameters['Sort']) {
			$Sort = 'TopAll'
		}
		$SearchParameters = [ordered]@{
			SearchString  = $SearchString
			CommunityId   = $CommunityId
			CommunityName = $CommunityName
			CreatorId     = $CreatorId
			Scope         = $Scope
			Sort          = $Sort
			Type          = 'Posts'
			ReturnLimit   = $ReturnLimit
		}
		Write-Verbose "SearchString"
		($SearchParameters.GetEnumerator() | Where-Object { -not $_.Value }) | ForEach-Object { $SearchParameters.Remove($_.Name) }
		$Posts = Search-Lemmy @SearchParameters | Where-Object { $_.post }
	}
	else {
		$Limit = $Global:__LemmyInstance.PageLimit
		if ($PSBoundParameters['ReturnLimit'] -and $PSBoundParameters['ReturnLimit'] -lt $Limit) {
			$Limit = $ReturnLimit
		}
		[Collections.Generic.List[PSObject]] $postsReturn = @()

		while ($page -gt -1) {
			$RequestParameters = @{
				community_id   = $CommunityId
				community_name = $CommunityName
				limit          = $Limit
				page           = $Page
				saved_only     = $SavedOnly
				sort           = $Sort
				type_          = $Scope
			}

			$results = Invoke-LemmyRestMethod -Uri '/post/list' -QueryParameters $RequestParameters -Method 'GET'
			$results | ForEach-Object { $postsReturn.Add($_) }
			$page++

			if (-not $results) {
				Write-Verbose "Not results"
				$page = -1
			}
			elseif ($PSCmdlet.ParameterSetName -eq 'DateRange') {
				$lastDate = $results | Select-Object @{l = 'id'; e = { $_.post.id } }, @{l = 'published'; e = { $_.post.published } }, 
				@{l = 'pinned'; e = { $_.post.featured_community } } | Where-Object { $_.pinned -eq $false } | Sort-Object published | 
				Select-Object -First 1 -ExpandProperty published
				Write-Verbose "LastDate: $($lastDate)"
				if ($lastDate -lt $StartTime) {
					$page = -1
				}
			}
			elseif ($postsReturn.Count -ge $ReturnLimit -and $ReturnLimit -gt 0) {
				Write-Verbose "ReturnLimit: $($postsReturn.Count) -gt $ReturnLimit"
				$page = -1
			}
		}
		$Posts = $postsReturn

		if ($PSCmdlet.ParameterSetName -eq 'DateRange') {
			Write-Verbose "DateTime Before: $($Posts.Count)"
			$Posts = $Posts | Where-Object { $_.post.published -gt $StartTime.ToUniversalTime() -and $_.post.published -le $EndTime.ToUniversalTime() }
			Write-Verbose "DateTime After: $($Posts.Count)"
		}
	}
	$Posts | Where-Object { $_.post } | Select-Object -ExpandProperty post -Property * -ExcludeProperty post
}
