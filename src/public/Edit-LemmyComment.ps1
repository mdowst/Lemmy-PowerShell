Function Edit-LemmyComment {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER CommentId

	.PARAMETER Content

	.PARAMETER Distinguished

	.PARAMETER FormId

	.PARAMETER LanguageId


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: editComment
    #>
    param(
		[int]$CommentId,
		[string]$Content,
		[boolean]$Distinguished,
		[string]$FormId,
		[int]$LanguageId
)
   
    	$RequestParameters = @{
		comment_id = $CommentId
		content = $Content
		distinguished = $Distinguished
		form_id = $FormId
		language_id = $LanguageId
}

    Invoke-LemmyRestMethod -Uri '/comment' -Method 'PUT' -RequestParameters $RequestParameters
}
