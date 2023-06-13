Function New-LemmyPrivateMessage {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Content

	.PARAMETER RecipientId


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: createPrivateMessage
    #>
    param(
		[string]$Content,
		[int]$RecipientId
)
   
    	$RequestParameters = @{
		content = $Content
		recipient_id = $RecipientId
}

    Invoke-LemmyRestMethod -Uri '/private_message' -Method 'POST' -RequestParameters $RequestParameters
}
