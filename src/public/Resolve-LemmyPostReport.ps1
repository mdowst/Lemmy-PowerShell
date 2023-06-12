Function Resolve-LemmyPostReport {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER ReportId

	.PARAMETER Resolved


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: resolvePostReport
    #>
    param(
		[int]$ReportId,
		[boolean]$Resolved
)
   
    	$RequestParameters = @{
		report_id = $ReportId
		resolved = $Resolved
}

    Invoke-LemmyRestMethod -Uri '/post/report/resolve' -Method 'PUT' -RequestParameters $RequestParameters
}
