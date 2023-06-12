Function Block-LemmyPerson {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Block

	.PARAMETER PersonId


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: blockPerson
    #>
    param(
		[boolean]$Block,
		[int]$PersonId
)
   
    	$RequestParameters = @{
		block = $Block
		person_id = $PersonId
}

    Invoke-LemmyRestMethod -Uri '/user/block' -Method 'POST' -RequestParameters $RequestParameters
}
