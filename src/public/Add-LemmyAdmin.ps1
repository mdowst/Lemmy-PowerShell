Function Add-LemmyAdmin {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Added

	.PARAMETER PersonId


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: addAdmin
    #>
    param(
		[boolean]$Added,
		[int]$PersonId
)
   
    	$RequestParameters = @{
		added = $Added
		person_id = $PersonId
}

    Invoke-LemmyRestMethod -Uri '/admin/add' -Method 'POST' -RequestParameters $RequestParameters
}
