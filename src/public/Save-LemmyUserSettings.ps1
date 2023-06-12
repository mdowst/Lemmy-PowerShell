Function Save-LemmyUserSettings {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Avatar

	.PARAMETER Banner

	.PARAMETER Bio

	.PARAMETER BotAccount

	.PARAMETER DefaultListingType

	.PARAMETER DefaultSortType

	.PARAMETER DiscussionLanguages

	.PARAMETER DisplayName

	.PARAMETER Email

	.PARAMETER InterfaceLanguage

	.PARAMETER MatrixUserId

	.PARAMETER SendNotificationsToEmail

	.PARAMETER ShowAvatars

	.PARAMETER ShowBotAccounts

	.PARAMETER ShowNewPostNotifs

	.PARAMETER ShowNsfw

	.PARAMETER ShowReadPosts

	.PARAMETER ShowScores

	.PARAMETER Theme


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: saveUserSettings
    #>
    param(
		[string]$Avatar,
		[string]$Banner,
		[string]$Bio,
		[boolean]$BotAccount,
		[int]$DefaultListingType,
		[int]$DefaultSortType,
		[number[]]$DiscussionLanguages,
		[string]$DisplayName,
		[string]$Email,
		[string]$InterfaceLanguage,
		[string]$MatrixUserId,
		[boolean]$SendNotificationsToEmail,
		[boolean]$ShowAvatars,
		[boolean]$ShowBotAccounts,
		[boolean]$ShowNewPostNotifs,
		[boolean]$ShowNsfw,
		[boolean]$ShowReadPosts,
		[boolean]$ShowScores,
		[string]$Theme
)
   
    	$RequestParameters = @{
		avatar = $Avatar
		banner = $Banner
		bio = $Bio
		bot_account = $BotAccount
		default_listing_type = $DefaultListingType
		default_sort_type = $DefaultSortType
		discussion_languages = $DiscussionLanguages
		display_name = $DisplayName
		email = $Email
		interface_language = $InterfaceLanguage
		matrix_user_id = $MatrixUserId
		send_notifications_to_email = $SendNotificationsToEmail
		show_avatars = $ShowAvatars
		show_bot_accounts = $ShowBotAccounts
		show_new_post_notifs = $ShowNewPostNotifs
		show_nsfw = $ShowNsfw
		show_read_posts = $ShowReadPosts
		show_scores = $ShowScores
		theme = $Theme
}

    Invoke-LemmyRestMethod -Uri '/user/save_user_settings' -Method 'PUT' -RequestParameters $RequestParameters
}
