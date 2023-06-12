Function Remove-LemmyPerson {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER PersonId

	.PARAMETER Reason


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: purgePerson
    #>
    param(
		[int]$PersonId,
		[string]$Reason
)
   
    	$RequestParameters = @{
		person_id = $PersonId
		reason = $Reason
}

    Invoke-LemmyRestMethod -Uri '/admin/purge/person' -Method 'POST' -RequestParameters $RequestParameters
}
