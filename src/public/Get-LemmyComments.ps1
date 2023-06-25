Function Get-LemmyComments {
	<#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Id
	The ID of the post

	.PARAMETER SearchString
	Specifies the text to find post title

	.PARAMETER CommunityId
	The ID of the community

	.PARAMETER CommunityName
	The name of the community

	.PARAMETER Limit
	The number of results to return

	.PARAMETER MaxDepth
	The max depth in which to search

	.PARAMETER ParentId
	The ID of the parent comment

	.PARAMETER PostId
	The ID of the post

	.PARAMETER Page
	Paging

	.PARAMETER SavedOnly
	Set to true for saved comments

	.PARAMETER Sort
	Sort type

	.PARAMETER Type
	Search 'All', 'Community', 'Local', or 'Subscribed'

    .EXAMPLE
    $post = Get-LemmyPost -CommunityName 'MyCommunity' -SearchString 'Hello Lemmy'
	Get-LemmyComments -PostId $post.post.id

	Searches for a post with the title 'Hello Lemmy' in the community 'MyCommunity' then gets the comments for the post
    
    .NOTES
    Lemmy API class: getComments
    #>
	[CmdletBinding(DefaultParameterSetName='Search')]
	param(
		[Parameter(Mandatory = $true, ParameterSetName = 'ID')]
		[int]$Id,
		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[string]$SearchString,
		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[int]$CommunityId,
		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[string]$CommunityName,
		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[int]$Limit,
		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[int]$MaxDepth,
		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[int]$Page,
		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[int]$ParentId,
		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[int]$PostId,
		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[boolean]$SavedOnly,
		[Parameter(Mandatory = $false, ParameterSetName = 'Search')]
		[ValidateSet('Hot', 'New', 'Old', 'Top')]
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
	
		$comments = Invoke-LemmyRestMethod -Uri '/comment' -Method 'GET' -RequestParameters $RequestParameters
	}
	else {
		$RequestParameters = @{
			community_id   = $CommunityId
			community_name = $CommunityName
			limit          = $Limit
			max_depth      = $MaxDepth
			page           = $Page
			parent_id      = $ParentId
			post_id        = $PostId
			saved_only     = $SavedOnly
			sort           = $Sort
			type_          = $Type
		}
		$query = $RequestParameters.GetEnumerator() | ForEach-Object {
			if ($_.Value) {
				"$($_.key)=$($_.Value)"
			}
		}

		$comments = Invoke-LemmyRestMethod -Uri ('/comment/list?' + ($query -join ('&'))) -Method 'GET' -RequestParameters $RequestParameters

		if($PSBoundParameters['SearchString']){
			$comments = $comments | Where-Object{ $_.comment.content -match $SearchString }
		}
	}
	$comments
}
