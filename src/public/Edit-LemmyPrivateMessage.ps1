Function Edit-LemmyPrivateMessage {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Content

	.PARAMETER PrivateMessageId


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: editPrivateMessage
    #>
    param(
		[string]$Content,
		[int]$PrivateMessageId
)
   
    	$RequestParameters = @{
		content = $Content
		private_message_id = $PrivateMessageId
}

    Invoke-LemmyRestMethod -Uri '/private_message' -Method 'PUT' -RequestParameters $RequestParameters
}
