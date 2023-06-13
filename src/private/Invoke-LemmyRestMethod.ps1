Function Invoke-LemmyRestMethod{
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
    param(
        $Uri,
        $Method,
        $RequestParameters
    )
    
    if(-not $PSBoundParameters['RequestParameters']){
        $RequestParameters = @{}
    }

    if(-not $Global:__LemmyInstance){
        throw "Run Connect-LemmyInstance to connect to a Lemmy instance"
    }
    elseif($Global:__LemmyInstance.auth){
        $RequestParameters.Add('auth', $Global:__LemmyInstance.auth)
    }
    

    $params = @{
        Uri = "$($Global:__LemmyInstance.Domain)/api/v3$($Uri)"
        Method = $Method
        ContentType = 'application/json'
        SkipCertificateCheck = $Global:__LemmyInstance.SkipCertificateCheck
    }

    if($RequestParameters.Count -gt 0){
        $params.Add('Body',($RequestParameters | ConvertTo-Json))
    }

    $request = Invoke-RestMethod @params
    if($request.psobject.Properties.Count -eq 1 -and $request.psobject.Properties.TypeNameOfValue -eq 'System.Object[]'){
        $request.psobject.Properties.Value
    }
    else{
        $request
    }

}