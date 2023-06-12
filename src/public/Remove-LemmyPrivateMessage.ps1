Function Remove-LemmyPrivateMessage {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Deleted

	.PARAMETER PrivateMessageId


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: deletePrivateMessage
    #>
    param(
		[boolean]$Deleted,
		[int]$PrivateMessageId
)
   
    	$RequestParameters = @{
		deleted = $Deleted
		private_message_id = $PrivateMessageId
}

    Invoke-LemmyRestMethod -Uri '/private_message/delete' -Method 'POST' -RequestParameters $RequestParameters
}
