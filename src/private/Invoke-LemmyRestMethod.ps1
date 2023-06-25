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
    [CmdletBinding()]
    param(
        $Uri,
        $Method,
        $RequestParameters
    )
    
    if(-not $PSBoundParameters['RequestParameters']){
        $RequestBody = @{}
    }
    else{
        $RequestBody = $RequestParameters.Clone()
    }

    if(-not $Global:__LemmyInstance){
        throw "Run Connect-LemmyInstance to connect to a Lemmy instance"
    }
    elseif($Global:__LemmyInstance.auth){
        $RequestBody.Add('auth', $Global:__LemmyInstance.auth)
    }
    

    $params = @{
        Uri = "$($Global:__LemmyInstance.Domain)/api/$($Global:__LemmyInstance.Api)$($Uri)"
        Method = $Method
        ContentType = 'application/json'
        SkipCertificateCheck = $Global:__LemmyInstance.SkipCertificateCheck
    }

    if($RequestBody.Count -gt 0){
        $params.Add('Body',($RequestBody | ConvertTo-Json))
    }

    $request = Invoke-RestMethod @params
    if($request.psobject.Properties.Count -eq 1 -and $request.psobject.Properties.TypeNameOfValue -eq 'System.Object[]'){
        $request.psobject.Properties.Value
    }
    else{
        $request
    }

}