Function Get-LemmyRegistrationApplications {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Limit

	.PARAMETER Page

	.PARAMETER UnreadOnly


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: listRegistrationApplications
    #>
    param(
		[int]$Limit,
		[int]$Page,
		[boolean]$UnreadOnly
)
   
    	$RequestParameters = @{
		limit = $Limit
		page = $Page
		unread_only = $UnreadOnly
}

    Invoke-LemmyRestMethod -Uri '/admin/registration_application/list' -Method 'GET' -RequestParameters $RequestParameters
}
