Function Get-LemmyCommunity {
    <#
    .SYNOPSIS
    Use to return a community
    
    .DESCRIPTION
    Can return local community based on ID or Name, perform a name search, or list all communities for a specific scope.
    
    .PARAMETER Id
    The ID of the community
    
    .PARAMETER Name
    The Name of the community. If there is no exact match for the name a partial name search is performed.
    
    .PARAMETER Sort
    The order in which to sort the results
    'Active', 'Hot', 'MostComments', 'New', 'NewComments', 'Old', 'TopAll', 'TopDay', 'TopMonth', 'TopWeek', 'TopYear'
    
    .PARAMETER Scope
    The scope in which to return communities from. Default is Local
    'All', 'Community', 'Local', 'Subscribed'
    
    .PARAMETER ReturnLimit
    The number of communities to return
        
    .EXAMPLE
    Get-LemmyCommunity -ID 123

    Returns the community with the ID 123

    .EXAMPLE
    Get-LemmyCommunity -Name "PowerShell"

    Returns the community with the name PowerShell

    .EXAMPLE
    Get-LemmyCommunity -Name "Power"

    Returns all communitied with "Power" in their name

    .EXAMPLE
    Get-LemmyCommunity

    Returns all communities from the local instance you are connected to.

    .EXAMPLE
    Get-LemmyCommunity -Scope Subscribed

    Returns all communities you are subscribed to.

    .NOTES
    Lemmy API class: listCommunities & getCommunity
    #>
    [CmdletBinding(DefaultParameterSetName = 'List')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'ID')]
        [int]$Id,
        
        [Parameter(Mandatory = $true, ParameterSetName = 'Name')]
        [string]$Name,

        [Parameter(Mandatory = $false, ParameterSetName = 'List')]
        [ValidateSet('Active', 'Hot', 'MostComments', 'New', 'NewComments', 'Old', 'TopAll', 'TopDay', 'TopMonth', 'TopWeek', 'TopYear')]
        [string]$Sort = 'TopMonth',
        [Parameter(Mandatory = $false, ParameterSetName = 'List')]
        [ValidateSet('All', 'Community', 'Local', 'Subscribed')]
        [string]$Scope = 'Local',
        [Parameter(Mandatory = $false, ParameterSetName = 'List')]
        [int]$ReturnLimit = 50
    )
    Test-LemmyConnection

    $community = $null
    if ($PSCmdlet.ParameterSetName -eq 'ID') {
        $community = Invoke-LemmyRestMethod -Uri '/community' -QueryParameters @{id=$Id} -Method 'GET'
    }
    elseif ($PSCmdlet.ParameterSetName -eq 'Name') {
        try {
            $request = Invoke-LemmyRestMethod -Uri '/community' -QueryParameters @{name=$name} -Method 'GET' -ErrorAction Stop
            $community = $request
        }
        catch {
            $search = Search-Lemmy -Type 'Communities' -SearchString $Name
            $community = $search
        }
    }
    else {
        [Collections.Generic.List[PSObject]] $communities = @()
        $Limit = $Global:__LemmyInstance.PageLimit
        if ($PSBoundParameters['ReturnLimit'] -and $PSBoundParameters['ReturnLimit'] -lt $Limit) {
            $Limit = $ReturnLimit
        }
        $page = 1
        do {
            $RequestParameters = [ordered]@{
                type_ = $Scope
                sort  = $Sort
                limit = $Limit
                page  = $page
            }
            
            $results = Invoke-LemmyRestMethod -Uri '/community/list' -QueryParameters $RequestParameters -Method 'GET'
            $results | ForEach-Object { $communities.Add($_) }
            $page++
        }while ($results -and ($communities.Count -lt $ReturnLimit -or $ReturnLimit -eq 0))
        $community = $communities
    }

    $Groupings = $community | Where-Object { $_.community } | Select-Object -ExpandProperty community -Property * -ExcludeProperty community | Group-Object -Property { $_.id }

    # Grouping and combining community returns because multiple returns with different properties can be returned for a single community. 
    foreach ($Group in $Groupings) {
        $properties = [ordered]@{}
        foreach ($g in $Group.Group) {
            $g.psobject.Properties | ForEach-Object {
                if (-not $properties.Contains($_.Name)) {
                    $properties.Add($_.Name, $_.Value)
                }
            }
        }
        [pscustomobject]$properties
    }
}
