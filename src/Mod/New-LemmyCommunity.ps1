Function New-LemmyCommunity {
	<#
    .SYNOPSIS
    Creates a new Lemmy Community

	.PARAMETER Name
	The internal name of the community. Should not contain spaces or special characters

	.PARAMETER Title
	The display name of the community.

	.PARAMETER Banner
	URL to Banner image

	.PARAMETER Description
	The option description

	.PARAMETER DiscussionLanguages
	Languages allowed in the community. Leave blank for all. To find specfic ones use Find-LemmySiteLanguages

	.PARAMETER Icon
	URL to a site icon
	
	.PARAMETER Nsfw
	Set to true to mark the community as not safe for work

	.PARAMETER PostingRestrictedToMods
	Set to true to prevent anyone other than mods from post to the community
	

    .EXAMPLE
    New-LemmyCommunity -name 'PowerShell' -Title 'PowerShell is Awesome'
    
    .NOTES
    Lemmy API class: createCommunity
    #>
	[CmdletBinding()]
	param(
		[string]$Name,
		[string]$Title,
		[string]$Banner,
		[string]$Description,
		[int[]]$DiscussionLanguages,
		[string]$Icon,
		[boolean]$Nsfw,
		[boolean]$PostingRestrictedToMods
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
