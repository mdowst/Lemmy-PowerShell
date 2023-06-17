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
    
    .PARAMETER FetchLimit
    The fetch limit used for pagination. The Lemmy default is 50, but if an admin has reduced it, you can supply that value here.
    
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
    [CmdletBinding(DefaultParameterSetName='List')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'ID')]
        [int]$Id,
        [Parameter(Mandatory = $true, ParameterSetName = 'Name')]
        [string]$Name,
        [Parameter(Mandatory = $false, ParameterSetName = 'List')]
        [ValidateSet('Active', 'Hot', 'MostComments', 'New', 'NewComments', 'Old', 'TopAll', 'TopDay', 'TopMonth', 'TopWeek', 'TopYear')]
        [string]$Sort = 'Active',
        [Parameter(Mandatory = $false, ParameterSetName = 'List')]
        [ValidateSet('All', 'Community', 'Local', 'Subscribed')]
        [string]$Scope = 'Local',
        [Parameter(Mandatory = $false, ParameterSetName = 'List')]
        [int]$ReturnLimit = 0,
        [Parameter(Mandatory = $false, ParameterSetName = 'List')]
        [int]$FetchLimit = 50
    )

    $community = $null
    if ($PSCmdlet.ParameterSetName -eq 'ID') {
        $request = Invoke-LemmyRestMethod -Uri ('/community?id=' + $Id) -Method 'GET' -RequestParameters $RequestParameters
        $community = $request | Where-Object { $_.community } | Select-Object -ExpandProperty community | Select-Object -Property * -Unique
    }
    elseif ($PSCmdlet.ParameterSetName -eq 'Name') {
        try {
            $request = Invoke-LemmyRestMethod -Uri ('/community?name=' + $name) -Method 'GET' -RequestParameters $RequestParameters -ErrorAction Stop
            $request | Where-Object { $_.community } | Select-Object -ExpandProperty community | Select-Object -Property * -Unique
        }
        catch {
            $search = Search-Lemmy -Type 'Communities' -Q $Name
            $community = $search | Where-Object { $_.community } | Select-Object -ExpandProperty community
        }
    }
    else {
        [Collections.Generic.List[PSObject]] $communities = @()
        $page = 1
        do {
            $RequestParameters = @{
                limit = $FetchLimit
                page  = $page
                sort  = $Sort
                type_ = $Scope
            }
            $query = $RequestParameters.GetEnumerator() | ForEach-Object {
                if ($_.Value) {
                    "$($_.key)=$($_.Value)"
                }
            }

            $results = Invoke-LemmyRestMethod -Uri ('/community/list?' + ($query -join ('&'))) -Method 'GET' -RequestParameters $RequestParameters
            $results | Where-Object { $_.community } | Select-Object -ExpandProperty community | ForEach-Object{ $communities.Add($_) }
            $page++
        }while($results -and ($communities.Count -lt $ReturnLimit -or $ReturnLimit -eq 0))
        $community = $communities
    }

    $community
}
