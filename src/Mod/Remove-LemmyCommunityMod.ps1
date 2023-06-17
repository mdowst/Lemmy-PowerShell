Function Remove-LemmyCommunityMod {
    <#
    .SYNOPSIS
    Remove a community moderator

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
        [int]$CommunityId,
        [int]$PersonId
    )
   
    $RequestParameters = @{
        added        = $false
        community_id = $CommunityId
        person_id    = $PersonId
    }

    Invoke-LemmyRestMethod -Uri '/community/mod' -Method 'POST' -RequestParameters $RequestParameters
}
