Function Get-LemmyPrivateMessageReports {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Limit

	.PARAMETER Page

	.PARAMETER UnresolvedOnly


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: listPrivateMessageReports
    #>
    param(
		[int]$Limit,
		[int]$Page,
		[boolean]$UnresolvedOnly
)
   
    	$RequestParameters = @{
		limit = $Limit
		page = $Page
		unresolved_only = $UnresolvedOnly
}

    Invoke-LemmyRestMethod -Uri '/private_message/report/list' -Method 'GET' -RequestParameters $RequestParameters
}
