Function Add-LemmyAdmin {
    <#
    .SYNOPSIS
    Add a user as a Lemmy admin

	.PARAMETER PersonId
    The PersonId of the user

    .EXAMPLE
    Add-LemmyAdmin -PersonId 3
    
    .NOTES
    Lemmy API class: addAdmin
    #>
    param(
        [int]$PersonId
    )
   
    $RequestParameters = @{
        added     = $true
        person_id = $PersonId
    }

    Invoke-LemmyRestMethod -Uri '/admin/add' -Method 'POST' -RequestParameters $RequestParameters
}
