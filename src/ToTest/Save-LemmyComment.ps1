Function Save-LemmyComment {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER CommentId

	.PARAMETER Save


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: saveComment
    #>
    param(
		[int]$CommentId,
		[boolean]$Save
)
   
    	$RequestParameters = @{
		comment_id = $CommentId
		save = $Save
}

    Invoke-LemmyRestMethod -Uri '/comment/save' -Method 'PUT' -RequestParameters $RequestParameters
}
