Function Set-LemmyPostAsRead {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER PostId

	.PARAMETER Read


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: markPostAsRead
    #>
    param(
		[int]$PostId,
		[boolean]$Read
)
   
    	$RequestParameters = @{
		post_id = $PostId
		read = $Read
}

    Invoke-LemmyRestMethod -Uri '/post/mark_as_read' -Method 'POST' -RequestParameters $RequestParameters
}
