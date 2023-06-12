Function Set-LemmyPersonMentionAsRead {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER PersonMentionId

	.PARAMETER Read


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: markPersonMentionAsRead
    #>
    param(
		[int]$PersonMentionId,
		[boolean]$Read
)
   
    	$RequestParameters = @{
		person_mention_id = $PersonMentionId
		read = $Read
}

    Invoke-LemmyRestMethod -Uri '/user/mention/mark_as_read' -Method 'POST' -RequestParameters $RequestParameters
}
