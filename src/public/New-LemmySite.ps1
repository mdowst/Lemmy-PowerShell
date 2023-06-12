Function New-LemmySite {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER ActorNameMaxLength

	.PARAMETER AllowedInstances

	.PARAMETER ApplicationEmailAdmins

	.PARAMETER ApplicationQuestion

	.PARAMETER Banner

	.PARAMETER BlockedInstances

	.PARAMETER CaptchaDifficulty

	.PARAMETER CaptchaEnabled

	.PARAMETER CommunityCreationAdminOnly

	.PARAMETER DefaultPostListingType

	.PARAMETER DefaultTheme

	.PARAMETER Description

	.PARAMETER DiscussionLanguages

	.PARAMETER EnableDownvotes

	.PARAMETER EnableNsfw

	.PARAMETER FederationDebug

	.PARAMETER FederationEnabled

	.PARAMETER FederationWorkerCount

	.PARAMETER HideModlogModNames

	.PARAMETER Icon

	.PARAMETER LegalInformation

	.PARAMETER Name

	.PARAMETER PrivateInstance

	.PARAMETER RateLimitComment

	.PARAMETER RateLimitCommentPerSecond

	.PARAMETER RateLimitImage

	.PARAMETER RateLimitImagePerSecond

	.PARAMETER RateLimitMessage

	.PARAMETER RateLimitMessagePerSecond

	.PARAMETER RateLimitPost

	.PARAMETER RateLimitPostPerSecond

	.PARAMETER RateLimitRegister

	.PARAMETER RateLimitRegisterPerSecond

	.PARAMETER RateLimitSearch

	.PARAMETER RateLimitSearchPerSecond

	.PARAMETER RegistrationMode

	.PARAMETER ReportsEmailAdmins

	.PARAMETER RequireEmailVerification

	.PARAMETER Sidebar

	.PARAMETER SlurFilterRegex

	.PARAMETER Taglines


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: createSite
    #>
    param(
		[int]$ActorNameMaxLength,
		[string[]]$AllowedInstances,
		[boolean]$ApplicationEmailAdmins,
		[string]$ApplicationQuestion,
		[string]$Banner,
		[string[]]$BlockedInstances,
		[string]$CaptchaDifficulty,
		[boolean]$CaptchaEnabled,
		[boolean]$CommunityCreationAdminOnly,
		[string]$DefaultPostListingType,
		[string]$DefaultTheme,
		[string]$Description,
		[number[]]$DiscussionLanguages,
		[boolean]$EnableDownvotes,
		[boolean]$EnableNsfw,
		[boolean]$FederationDebug,
		[boolean]$FederationEnabled,
		[int]$FederationWorkerCount,
		[boolean]$HideModlogModNames,
		[string]$Icon,
		[string]$LegalInformation,
		[string]$Name,
		[boolean]$PrivateInstance,
		[int]$RateLimitComment,
		[int]$RateLimitCommentPerSecond,
		[int]$RateLimitImage,
		[int]$RateLimitImagePerSecond,
		[int]$RateLimitMessage,
		[int]$RateLimitMessagePerSecond,
		[int]$RateLimitPost,
		[int]$RateLimitPostPerSecond,
		[int]$RateLimitRegister,
		[int]$RateLimitRegisterPerSecond,
		[int]$RateLimitSearch,
		[int]$RateLimitSearchPerSecond,
				[ValidateSet('Closed','Open','RequireApplication')]
		[string]$RegistrationMode,
		[boolean]$ReportsEmailAdmins,
		[boolean]$RequireEmailVerification,
		[string]$Sidebar,
		[string]$SlurFilterRegex,
		[string[]]$Taglines
)
   
    	$RequestParameters = @{
		actor_name_max_length = $ActorNameMaxLength
		allowed_instances = $AllowedInstances
		application_email_admins = $ApplicationEmailAdmins
		application_question = $ApplicationQuestion
		banner = $Banner
		blocked_instances = $BlockedInstances
		captcha_difficulty = $CaptchaDifficulty
		captcha_enabled = $CaptchaEnabled
		community_creation_admin_only = $CommunityCreationAdminOnly
		default_post_listing_type = $DefaultPostListingType
		default_theme = $DefaultTheme
		description = $Description
		discussion_languages = $DiscussionLanguages
		enable_downvotes = $EnableDownvotes
		enable_nsfw = $EnableNsfw
		federation_debug = $FederationDebug
		federation_enabled = $FederationEnabled
		federation_worker_count = $FederationWorkerCount
		hide_modlog_mod_names = $HideModlogModNames
		icon = $Icon
		legal_information = $LegalInformation
		name = $Name
		private_instance = $PrivateInstance
		rate_limit_comment = $RateLimitComment
		rate_limit_comment_per_second = $RateLimitCommentPerSecond
		rate_limit_image = $RateLimitImage
		rate_limit_image_per_second = $RateLimitImagePerSecond
		rate_limit_message = $RateLimitMessage
		rate_limit_message_per_second = $RateLimitMessagePerSecond
		rate_limit_post = $RateLimitPost
		rate_limit_post_per_second = $RateLimitPostPerSecond
		rate_limit_register = $RateLimitRegister
		rate_limit_register_per_second = $RateLimitRegisterPerSecond
		rate_limit_search = $RateLimitSearch
		rate_limit_search_per_second = $RateLimitSearchPerSecond
		registration_mode = $RegistrationMode
		reports_email_admins = $ReportsEmailAdmins
		require_email_verification = $RequireEmailVerification
		sidebar = $Sidebar
		slur_filter_regex = $SlurFilterRegex
		taglines = $Taglines
}

    Invoke-LemmyRestMethod -Uri '/site' -Method 'POST' -RequestParameters $RequestParameters
}
