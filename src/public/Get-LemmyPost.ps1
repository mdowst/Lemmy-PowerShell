Function Get-LemmyPost {
	<#
    .SYNOPSIS
    Get a post by ID or search for a post

	.PARAMETER Id
	The ID of the post

	.PARAMETER CommunityId
	The ID of the community

	.PARAMETER CommunityName
	The name of the community

	.PARAMETER Limit
	The number of results to return

	.PARAMETER Page
	Paging

	.PARAMETER SavedOnly
	Set to true for saved posts

	.PARAMETER Sort
	Sort type

	.PARAMETER Type
	Search 'All', 'Community', 'Local', or 'Subscribed'

    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: getPosts
    #>
	[CmdletBinding(DefaultParameterSetName='Search')]
	param(
		[Parameter(Mandatory = $true, ParameterSetName = 'ID')]
		[int]$Id,
		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[int]$CommunityId,
		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[string]$CommunityName,
		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[int]$Limit,
		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[int]$Page,
		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[boolean]$SavedOnly,
		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[ValidateSet('Active', 'Hot', 'MostComments', 'New', 'NewComments', 'Old', 'TopAll', 'TopDay', 'TopMonth', 'TopWeek', 'TopYear')]
		[string]$Sort,
		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[ValidateSet('All', 'Community', 'Local', 'Subscribed')]
		[string]$Type
	)
   
	if ($PSCmdlet.ParameterSetName -eq 'ID') {
		$RequestParameters = @{
			comment_id = $null
			id = $Id
		}
	
		Invoke-LemmyRestMethod -Uri '/post' -Method 'GET' -RequestParameters $RequestParameters
	}
	else {
		$RequestParameters = @{
			community_id   = $CommunityId
			community_name = $CommunityName
			limit          = $Limit
			page           = $Page
			saved_only     = $SavedOnly
			sort           = $Sort
			type_          = $Type
		}
		$query = $RequestParameters.GetEnumerator() | ForEach-Object {
			if ($_.Value) {
				"$($_.key)=$($_.Value)"
			}
		}

		Invoke-LemmyRestMethod -Uri ('/post/list?' + ($query -join ('&'))) -Method 'GET' -RequestParameters $RequestParameters
	}
}
