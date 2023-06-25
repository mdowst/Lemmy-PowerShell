Function New-LemmyComment {
	<#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Content
	The content of the comment

	.PARAMETER FormId
	The ID of the form (I guess)

	.PARAMETER LanguageId
	The ID of the language to make the post with
	
	.PARAMETER ParentId
	The ID of the parent comment

	.PARAMETER PostId
	The ID of the post


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
		content     = $Content
		form_id     = $FormId
		language_id = $LanguageId
		parent_id   = $ParentId
		post_id     = $PostId
	}
	$RequestParametersClean = @{}
	$RequestParameters.GetEnumerator() | ForEach-Object {
		if ($_.Value) {
			$RequestParametersClean.Add($_.key,$_.Value)
		}
	}
	Invoke-LemmyRestMethod -Uri '/comment' -Method 'POST' -RequestParameters $RequestParametersClean
}
