Function New-LemmyPost {
	<#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Body
	The Body of the post

	.PARAMETER CommunityId
	The ID of the community to post to. Use Find-Community to determine the ID

	.PARAMETER Honeypot
	I honestly don't know what this does

	.PARAMETER LanguageId
	The ID of the language to make the post with

	.PARAMETER Name
	The Title of the post

	.PARAMETER Nsfw
	Set to true to mark the post of not safe for work

	.PARAMETER Url
	The URL of the link to include in the post

    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: createPost
    #>
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $false)]
		[string]$Body,
		[Parameter(Mandatory = $true)]
		[int]$CommunityId,
		[Parameter(Mandatory = $false)]
		[string]$Honeypot,
		[Parameter(Mandatory = $false)]
		[int]$LanguageId = 37,
		[Parameter(Mandatory = $true)]
		[string]$Name,
		[Parameter(Mandatory = $false)]
		[boolean]$Nsfw = $false,
		[Parameter(Mandatory = $false)]
		[string]$Url
	)
   
	$RequestParameters = @{
		body         = $Body
		community_id = $CommunityId
		honeypot     = $Honeypot
		language_id  = $LanguageId
		name         = $Name
		nsfw         = $Nsfw
		url          = $Url
	}

	Invoke-LemmyRestMethod -Uri '/post' -Method 'POST' -RequestParameters $RequestParameters
}
