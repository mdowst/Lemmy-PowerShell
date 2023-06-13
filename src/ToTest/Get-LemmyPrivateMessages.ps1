Function Get-LemmyPrivateMessages {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Limit

	.PARAMETER Page

	.PARAMETER UnreadOnly


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: getPrivateMessages
    #>
    param(
		[int]$Limit,
		[int]$Page,
		[boolean]$UnreadOnly
)
   
    	$RequestParameters = @{
		limit = $Limit
		page = $Page
		unread_only = $UnreadOnly
}

    Invoke-LemmyRestMethod -Uri '/private_message/list' -Method 'GET' -RequestParameters $RequestParameters
}
