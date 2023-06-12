Function Resolve-LemmyCommentReport {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER ReportId

	.PARAMETER Resolved


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: resolveCommentReport
    #>
    param(
		[int]$ReportId,
		[boolean]$Resolved
)
   
    	$RequestParameters = @{
		report_id = $ReportId
		resolved = $Resolved
}

    Invoke-LemmyRestMethod -Uri '/comment/report/resolve' -Method 'PUT' -RequestParameters $RequestParameters
}
