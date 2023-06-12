Function New-LemmyPost {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Body

	.PARAMETER CommunityId

	.PARAMETER Honeypot

	.PARAMETER LanguageId

	.PARAMETER Name

	.PARAMETER Nsfw

	.PARAMETER Url


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: createPost
    #>
    param(
		[string]$Body,
		[int]$CommunityId,
		[string]$Honeypot,
		[int]$LanguageId,
		[string]$Name,
		[boolean]$Nsfw,
		[string]$Url
)
   
    	$RequestParameters = @{
		body = $Body
		community_id = $CommunityId
		honeypot = $Honeypot
		language_id = $LanguageId
		name = $Name
		nsfw = $Nsfw
		url = $Url
}

    Invoke-LemmyRestMethod -Uri '/post' -Method 'POST' -RequestParameters $RequestParameters
}
