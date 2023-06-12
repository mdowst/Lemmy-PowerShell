Function Edit-LemmyCommunity {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Banner

	.PARAMETER CommunityId

	.PARAMETER Description

	.PARAMETER DiscussionLanguages

	.PARAMETER Icon

	.PARAMETER Nsfw

	.PARAMETER PostingRestrictedToMods

	.PARAMETER Title


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: editCommunity
    #>
    param(
		[string]$Banner,
		[int]$CommunityId,
		[string]$Description,
		[number[]]$DiscussionLanguages,
		[string]$Icon,
		[boolean]$Nsfw,
		[boolean]$PostingRestrictedToMods,
		[string]$Title
)
   
    	$RequestParameters = @{
		banner = $Banner
		community_id = $CommunityId
		description = $Description
		discussion_languages = $DiscussionLanguages
		icon = $Icon
		nsfw = $Nsfw
		posting_restricted_to_mods = $PostingRestrictedToMods
		title = $Title
}

    Invoke-LemmyRestMethod -Uri '/community' -Method 'PUT' -RequestParameters $RequestParameters
}
