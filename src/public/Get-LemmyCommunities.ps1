Function Get-LemmyCommunities {
	<#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Limit

	.PARAMETER Page

	.PARAMETER Sort

	.PARAMETER Type


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: listCommunities
    #>
	param(
		[int]$Limit,
		[int]$Page,
		[ValidateSet('Active', 'Hot', 'MostComments', 'New', 'NewComments', 'Old', 'TopAll', 'TopDay', 'TopMonth', 'TopWeek', 'TopYear')]
		[string]$Sort,
		[ValidateSet('All', 'Community', 'Local', 'Subscribed')]
		[string]$Type
	)
   
	$RequestParameters = @{
		limit = $Limit
		page  = $Page
		sort  = $Sort
		type_ = $Type
	}

	Invoke-LemmyRestMethod -Uri '/community/list' -Method 'GET' -RequestParameters $RequestParameters
}
