Function Get-LemmyPost {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER CommentId

	.PARAMETER Id


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: getPost
    #>
    param(
		[int]$CommentId,
		[int]$Id
)
   
    	$RequestParameters = @{
		comment_id = $CommentId
		id = $Id
}

    Invoke-LemmyRestMethod -Uri '/post' -Method 'GET' -RequestParameters $RequestParameters
}
