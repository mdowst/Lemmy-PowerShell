Function Remove-LemmyAdmin {
    <#
    .SYNOPSIS
    Removes a site admin

	.PARAMETER PersonId
    The PersonId of the user

    .EXAMPLE
    Remove-LemmyAdmin -PersonId 3
    
    .NOTES
    Lemmy API class: addAdmin
    #>
    [CmdletBinding()]
    param(
        [int]$PersonId
    )
   
    $RequestParameters = @{
        added     = $false
        person_id = $PersonId
    }

    Invoke-LemmyRestMethod -Uri '/admin/add' -Method 'POST' -RequestParameters $RequestParameters
}
