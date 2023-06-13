Function Get-LemmyReportCount {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER CommunityId


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: getReportCount
    #>
    param(
		[int]$CommunityId
)
   
    	$RequestParameters = @{
		community_id = $CommunityId
}

    Invoke-LemmyRestMethod -Uri '/user/report_count' -Method 'GET' -RequestParameters $RequestParameters
}
