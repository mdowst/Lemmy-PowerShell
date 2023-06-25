Function Remove-LemmyModerator {
    <#
    .SYNOPSIS
    Remove a community moderator (Moderator permissions required)

	.PARAMETER CommunityId
    The ID of the communituy

	.PARAMETER PersonId
    The ID of the person

    .EXAMPLE
    Remove-LemmyCommunityMod -CommunityId 123 -PersonId 456
    
    .NOTES
    Lemmy API class: addModToCommunity
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [int]$CommunityId,
        [Parameter(Mandatory = $true)]
        [int]$PersonId
    )
   
    $RequestParameters = @{
        added        = $false
        community_id = $CommunityId
        person_id    = $PersonId
    }

    Invoke-LemmyRestMethod -Uri '/community/mod' -Method 'POST' -RequestParameters $RequestParameters
}
