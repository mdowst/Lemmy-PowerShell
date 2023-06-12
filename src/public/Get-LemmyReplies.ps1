Function Get-LemmyReplies {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Limit

	.PARAMETER Page

	.PARAMETER Sort

	.PARAMETER UnreadOnly


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: getReplies
    #>
    param(
		[int]$Limit,
		[int]$Page,
				[ValidateSet('Hot','New','Old','Top')]
		[string]$Sort,
		[boolean]$UnreadOnly
)
   
    	$RequestParameters = @{
		limit = $Limit
		page = $Page
		sort = $Sort
		unread_only = $UnreadOnly
}

    Invoke-LemmyRestMethod -Uri '/user/replies' -Method 'GET' -RequestParameters $RequestParameters
}
