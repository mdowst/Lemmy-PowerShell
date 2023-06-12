Function Set-LemmyPrivateMessageAsRead {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER PrivateMessageId

	.PARAMETER Read


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: markPrivateMessageAsRead
    #>
    param(
		[int]$PrivateMessageId,
		[boolean]$Read
)
   
    	$RequestParameters = @{
		private_message_id = $PrivateMessageId
		read = $Read
}

    Invoke-LemmyRestMethod -Uri '/private_message/mark_as_read' -Method 'POST' -RequestParameters $RequestParameters
}
