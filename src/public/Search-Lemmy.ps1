Function Search-Lemmy {
	<#
    .SYNOPSIS
    Search Lemmy Comments, Communities, Posts, and Users

	.PARAMETER SearchString
	Specifies the text to search

	.PARAMETER CommunityId
	The ID of the community to search

	.PARAMETER CommunityName
	The name of the community to search

	.PARAMETER CreatorId
	The creator ID of the person to search

	.PARAMETER Scope
	The scope in which to return search in. Default is Local
	'All', 'Community', 'Local', 'Subscribed'
	
	.PARAMETER Sort
	Sort type 'Active', 'Hot', 'MostComments', 'New', 'NewComments', 'Old', 'TopAll', 'TopDay', 'TopMonth', 'TopWeek', 'TopYear'
	
	.PARAMETER Type
	Search 'All', 'Comments', 'Communities', 'Posts', 'Url', 'Users'


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: search
    #>
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $true)]
		[string]$SearchString,	

		[Parameter(Mandatory = $false)]
		[int]$CommunityId,

		[Parameter(Mandatory = $false)]
		[string]$CommunityName,

		[Parameter(Mandatory = $false)]
		[int]$CreatorId,

		[Parameter(Mandatory = $false)]
		[ValidateSet('All', 'Community', 'Local', 'Subscribed')]
		[string]$Scope = 'Local',
				
		[Parameter(Mandatory = $false)]
		[ValidateSet('Active', 'Hot', 'MostComments', 'New', 'NewComments', 'Old', 'TopAll', 'TopDay', 'TopMonth', 'TopWeek', 'TopYear')]
		[string]$Sort,
		
		[Parameter(Mandatory = $false)]
		[ValidateSet('All', 'Comments', 'Communities', 'Posts', 'Url', 'Users')]
		[string]$Type,
		
		[Parameter(Mandatory = $false)]
		[int]$ReturnLimit = 50
	)
	Test-LemmyConnection
	
	$Limit = $Global:__LemmyInstance.PageLimit
	if ($PSBoundParameters['ReturnLimit'] -and $PSBoundParameters['ReturnLimit'] -lt $Limit) {
		$Limit = $ReturnLimit
	}

	[Collections.Generic.List[PSObject]] $searchResults = @()
	$page = 1
	while ($page -gt -1) {
		$RequestParameters = [ordered]@{
			q              = $SearchString
			community_id   = $CommunityId
			community_name = $CommunityName
			creator_id     = $CreatorId
			type_          = $Type
			sort           = $Sort
			listing_type   = $Scope
			page           = $Page
			limit          = $Limit
		}

		$results = Invoke-LemmyRestMethod -Uri '/search' -QueryParameters $RequestParameters -Method 'GET'
		$results | ForEach-Object { $searchResults.Add($_) }
		Write-Verbose "Results Count : $($searchResults.Count)"
		$page++

		if (-not $results) {
			Write-Verbose "Not results"
			$page = -1
		}
		elseif ($searchResults.Count -ge $ReturnLimit -and $ReturnLimit -gt 0) {
			Write-Verbose "ReturnLimit: $($searchResults.Count) -gt $ReturnLimit"
			$page = -1
		}
		elseif ($results.Count -lt $Limit) {
			Write-Verbose "Less than Limit: $($results.Count) -lt $Limit"
			$page = -1
		}
	}
	$searchResults
}
