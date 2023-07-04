Function Invoke-LemmyRestMethod {
    <#
    .SYNOPSIS
    Call Lemmy API
    
    .PARAMETER Uri
    
    .PARAMETER Method
    Parameter description
    
    .PARAMETER RequestParameters
    Parameter description
    
    .EXAMPLE
    An example
    
    .NOTES
    General notes
    #>
    [CmdletBinding()]
    param(
        $Uri,
        $Method,
        [Parameter(Mandatory = $false, ParameterSetName = 'Body')]
        $RequestParameters,
        [Parameter(Mandatory = $false, ParameterSetName = 'Query')]
        $QueryParameters
    )
    Test-LemmyConnection
 
    $params = @{
        Uri                  = "$($Global:__LemmyInstance.Domain)/api/$($Global:__LemmyInstance.Api)$($Uri)"
        Method               = $Method
        ContentType          = 'application/json'
        SkipCertificateCheck = $Global:__LemmyInstance.SkipCertificateCheck
    }
    Write-Verbose "URI : $($params['Uri'])"

    if ($PSBoundParameters['QueryParameters']) {
        $query = $QueryParameters.GetEnumerator() | ForEach-Object {
            if ($_.Value) {
                "$($_.key)=$($_.Value)"
            }
        }
        $params['Uri'] = $params['Uri'] + '?' + ($query -join ('&'))
        Write-Verbose "Query URI : $($params['Uri'])"
        $params['Uri'] = $params['Uri'] + '&auth=' + $Global:__LemmyInstance.auth
    }
    elseif ($PSBoundParameters['RequestParameters']){
        $RequestBody = $RequestParameters.Clone()
        $RequestBody.Add('auth', $Global:__LemmyInstance.auth)
        $params.Add('Body', ($RequestBody | ConvertTo-Json))
    }

    $request = Invoke-RestMethod @params
    if ($request.psobject.Properties.Count -eq 1 -and $request.psobject.Properties.TypeNameOfValue -eq 'System.Object[]') {
        $request.psobject.Properties.Value
    }
    else {
        $request
    }

}