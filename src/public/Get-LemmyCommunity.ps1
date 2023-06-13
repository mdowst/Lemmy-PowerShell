Function Get-LemmyCommunity {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Id

	.PARAMETER Name


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: getCommunity
    #>
    param(
        [int]$Id,
        [string]$Name
    )
   
    $RequestParameters = @{
        id   = $Id
        name = $Name
    }

    $query = $RequestParameters.GetEnumerator() | ForEach-Object {
        if ($_.Value) {
            "$($_.key)=$($_.Value)"
        }
    }
    $request = Invoke-LemmyRestMethod -Uri ('/community?' + ($query -join('&'))) -Method 'GET' -RequestParameters $RequestParameters
    $request | Where-Object{ $_.community } | Select-Object -ExpandProperty community | Select-Object -Property * -Unique
}
