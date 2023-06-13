Function New-LemmyPrivateMessageReport {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER PrivateMessageId

	.PARAMETER Reason


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: createPrivateMessageReport
    #>
    param(
		[int]$PrivateMessageId,
		[string]$Reason
)
   
    	$RequestParameters = @{
		private_message_id = $PrivateMessageId
		reason = $Reason
}

    Invoke-LemmyRestMethod -Uri '/private_message/report' -Method 'POST' -RequestParameters $RequestParameters
}
