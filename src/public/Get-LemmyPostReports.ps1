Function Get-LemmyPostReports {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER CommunityId

	.PARAMETER Limit

	.PARAMETER Page

	.PARAMETER UnresolvedOnly


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: listPostReports
    #>
    param(
		[int]$CommunityId,
		[int]$Limit,
		[int]$Page,
		[boolean]$UnresolvedOnly
)
   
    	$RequestParameters = @{
		community_id = $CommunityId
		limit = $Limit
		page = $Page
		unresolved_only = $UnresolvedOnly
}

    Invoke-LemmyRestMethod -Uri '/post/report/list' -Method 'GET' -RequestParameters $RequestParameters
}
