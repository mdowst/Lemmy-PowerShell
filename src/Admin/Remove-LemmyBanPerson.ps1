Function Remove-LemmyBanPerson {
	<#
    .SYNOPSIS
    Removes a ban from a user

	.PARAMETER PersonId
	The ID of the person to ban

    .EXAMPLE
    Remove-LemmyBanPerson -PersonId 3
    
    .NOTES
    Lemmy API class: banPerson
    #>
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $true)]
		[int]$PersonId
	)
   
	$RequestParameters = @{
		ban         = $false
		person_id   = $PersonId
	}

	Invoke-LemmyRestMethod -Uri '/user/ban' -Method 'POST' -RequestParameters $RequestParameters
}
