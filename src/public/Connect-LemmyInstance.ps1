Function Connect-LemmyInstance {
    <#
    .SYNOPSIS
    Call Lemmy API
    
	.PARAMETER Password

	.PARAMETER UsernameOrEmail

    .PARAMETER Instance
    The Lemmy instance to connect to

    .EXAMPLE
    An example
    
    .NOTES
    General notes
    #>
    param(
        [ValidatePattern('^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$')]    
        [string]$Uri,
        [pscredential]$Credential,
        [switch]$PassThru
    )

    $RequestBody = @{
        password = $credential.GetNetworkCredential().Password
        username_or_email = $Credential.UserName
    } | ConvertTo-Json
    
    
    $URI = $URI -replace('/$','')
    

    $authRequest = Invoke-RestMethod -Uri "$($Uri)/api/v3/user/login" -Method 'POST' -Body $RequestBody -ContentType 'application/json'

    $Instance = [PSCustomObject]@{
        Domain = $Uri
        auth = $authRequest.jwt
    }
    $global:__LemmyInstance = $Instance

    if($PassThru){
        $Instance
    }
    else{
        Write-Output "Connected to $($Instance.Domain)"
    }
}
