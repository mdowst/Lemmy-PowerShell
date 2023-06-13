Function Edit-LemmyPost {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Body

	.PARAMETER LanguageId

	.PARAMETER Name

	.PARAMETER Nsfw

	.PARAMETER PostId

	.PARAMETER Url


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: editPost
    #>
    param(
		[string]$Body,
		[int]$LanguageId,
		[string]$Name,
		[boolean]$Nsfw,
		[int]$PostId,
		[string]$Url
)
   
    	$RequestParameters = @{
		body = $Body
		language_id = $LanguageId
		name = $Name
		nsfw = $Nsfw
		post_id = $PostId
		url = $Url
}

    Invoke-LemmyRestMethod -Uri '/post' -Method 'PUT' -RequestParameters $RequestParameters
}
