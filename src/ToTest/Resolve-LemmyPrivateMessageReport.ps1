Function Resolve-LemmyPrivateMessageReport {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER ReportId

	.PARAMETER Resolved


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: resolvePrivateMessageReport
    #>
    param(
		[int]$ReportId,
		[boolean]$Resolved
)
   
    	$RequestParameters = @{
		report_id = $ReportId
		resolved = $Resolved
}

    Invoke-LemmyRestMethod -Uri '/private_message/report/resolve' -Method 'PUT' -RequestParameters $RequestParameters
}
