Function Add-LemmyModerator {
    <#
    .SYNOPSIS
    Add a community moderator (Moderator permissions required)

	.PARAMETER CommunityId
    The ID of the communituy

	.PARAMETER PersonId
    The ID of the person

    .EXAMPLE
    Add-LemmyCommunityMod -CommunityId 123 -PersonId 456
    
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
        added        = $true
        community_id = $CommunityId
        person_id    = $PersonId
    }

    Invoke-LemmyRestMethod -Uri '/community/mod' -Method 'POST' -RequestParameters $RequestParameters
}
