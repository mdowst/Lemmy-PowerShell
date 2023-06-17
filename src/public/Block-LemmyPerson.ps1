Function Block-LemmyPerson {
    <#
    .SYNOPSIS
    Block a user from your account

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
        block     = $true
        person_id = $PersonId
    }

    Invoke-LemmyRestMethod -Uri '/user/block' -Method 'POST' -RequestParameters $RequestParameters
}
