Function New-LemmyCommunity {
	<#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Banner

	.PARAMETER Description

	.PARAMETER DiscussionLanguages

	.PARAMETER Icon

	.PARAMETER Name

	.PARAMETER Nsfw

	.PARAMETER PostingRestrictedToMods

	.PARAMETER Title


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: createCommunity
    #>
	param(
		[string]$Banner,
		[string]$Description,
		[int[]]$DiscussionLanguages,
		[string]$Icon,
		[string]$Name,
		[boolean]$Nsfw,
		[boolean]$PostingRestrictedToMods,
		[string]$Title
	)
   
	$RequestParameters = @{
		banner                     = $Banner
		description                = $Description
		discussion_languages       = $DiscussionLanguages
		icon                       = $Icon
		name                       = $Name
		nsfw                       = $Nsfw
		posting_restricted_to_mods = $PostingRestrictedToMods
		title                      = $Title
	}

	Invoke-LemmyRestMethod -Uri '/community' -Method 'POST' -RequestParameters $RequestParameters
}
