Function Get-LemmyPerson {
    <#
    .SYNOPSIS
    Get a Lemmy user
    
    .PARAMETER Id
    The ID of the user

    .PARAMETER Name
    All or part of the user's name
    
    .EXAMPLE
    Get-LemmyPerson -UserName 'pwshtester'
    
    .EXAMPLE
    Get-LemmyPerson -Id 3

    .NOTES
    General notes
    #>
    [CmdletBinding(DefaultParameterSetName='Name')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'ID')]
		[int]$Id,
		[Parameter(Mandatory = $true, ParameterSetName = 'Name')]
		[string]$Name
    )

    $RequestParameters = @{
        person_id = $Id
        username  = $Name
    }
    $query = $RequestParameters.GetEnumerator() | ForEach-Object {
        if ($_.Value) {
            "$($_.key)=$($_.Value)"
        }
    }
    try {
        $person = Invoke-LemmyRestMethod -Uri ('/user?' + ($query -join ('&'))) -Method 'GET' -ErrorAction Stop
    }
    catch {
        if($PSCmdlet.ParameterSetName -eq 'Name'){
            $person = Search-Lemmy -Type 'Users' -SearchString $Name
        }
        else{
            throw "UserId $($Id) not found"
        }
    }
    $person | Where-Object { $_.person } | Select-Object -ExpandProperty person
}