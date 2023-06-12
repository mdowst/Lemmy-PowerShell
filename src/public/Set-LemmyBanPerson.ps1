Function Set-LemmyBanPerson {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Ban

	.PARAMETER Expires

	.PARAMETER PersonId

	.PARAMETER Reason

	.PARAMETER RemoveData


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: banPerson
    #>
    param(
		[boolean]$Ban,
		[int]$Expires,
		[int]$PersonId,
		[string]$Reason,
		[boolean]$RemoveData
)
   
    	$RequestParameters = @{
		ban = $Ban
		expires = $Expires
		person_id = $PersonId
		reason = $Reason
		remove_data = $RemoveData
}

    Invoke-LemmyRestMethod -Uri '/user/ban' -Method 'POST' -RequestParameters $RequestParameters
}
