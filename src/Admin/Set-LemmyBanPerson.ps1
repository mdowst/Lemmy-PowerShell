Function Set-LemmyBanPerson {
	<#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER PersonId
	The ID of the person to ban

	.PARAMETER Expires
	Number of days for the ban to last

	.PARAMETER Reason
	Reason for the ban

	.PARAMETER RemoveData
	Set to true to remove the user's content

    .EXAMPLE
    Set-LemmyBanPerson -PersonId 3 -Reason 'Being a big bad meany' -Expires 3
    
    .NOTES
    Lemmy API class: banPerson
    #>
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $true)]
		[int]$PersonId,
		[Parameter(Mandatory = $false)]
		[string]$Reason,
		[Parameter(Mandatory = $false)]
		[int]$Expires,
		[Parameter(Mandatory = $false)]
		[boolean]$RemoveData = $false
	)
   
	$RequestParameters = @{
		ban         = $true
		expires     = $Expires
		person_id   = $PersonId
		reason      = $Reason
		remove_data = $RemoveData
	}

	Invoke-LemmyRestMethod -Uri '/user/ban' -Method 'POST' -RequestParameters $RequestParameters
}
