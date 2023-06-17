Function Get-LemmyComments {
	<#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER CommunityId

	.PARAMETER CommunityName

	.PARAMETER Limit

	.PARAMETER MaxDepth

	.PARAMETER Page

	.PARAMETER ParentId

	.PARAMETER PostId

	.PARAMETER SavedOnly

	.PARAMETER Sort

	.PARAMETER Type


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: getComments
    #>
	param(
		[int]$CommunityId,
		[string]$CommunityName,
		[int]$Limit,
		[int]$MaxDepth,
		[int]$Page,
		[int]$ParentId,
		[int]$PostId,
		[boolean]$SavedOnly,
		[ValidateSet('Hot', 'New', 'Old', 'Top')]
		[string]$Sort,
		[ValidateSet('All', 'Community', 'Local', 'Subscribed')]
		[string]$Type
	)
   
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

	Invoke-LemmyRestMethod -Uri '/comment/list' -Method 'GET' -RequestParameters $RequestParameters
}
