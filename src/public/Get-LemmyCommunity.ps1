Function Get-LemmyCommunity {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Id

	.PARAMETER Name


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: getCommunity
    #>
    param(
		[int]$Id,
		[string]$Name
)
   
    	$RequestParameters = @{
		id = $Id
		name = $Name
}

    Invoke-LemmyRestMethod -Uri '/community' -Method 'GET' -RequestParameters $RequestParameters
}
