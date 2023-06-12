Function New-LemmyComment {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Content

	.PARAMETER FormId

	.PARAMETER LanguageId

	.PARAMETER ParentId

	.PARAMETER PostId


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: createComment
    #>
    param(
		[string]$Content,
		[string]$FormId,
		[int]$LanguageId,
		[int]$ParentId,
		[int]$PostId
)
   
    	$RequestParameters = @{
		content = $Content
		form_id = $FormId
		language_id = $LanguageId
		parent_id = $ParentId
		post_id = $PostId
}

    Invoke-LemmyRestMethod -Uri '/comment' -Method 'POST' -RequestParameters $RequestParameters
}
