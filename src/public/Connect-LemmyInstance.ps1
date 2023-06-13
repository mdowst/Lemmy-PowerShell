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
        [string]$Uri,
        [pscredential]$Credential,
        [switch]$SkipCertificateCheck=$false,
        [switch]$PassThru
    )

    $RequestBody = @{
        password          = $credential.GetNetworkCredential().Password
        username_or_email = $Credential.UserName
    } | ConvertTo-Json
    
    
    $URI = $URI -replace ('/$', '')
    
    $InvokeRestMethodParam = @{
        Uri         = "$($Uri)/api/v3/user/login"
        Method      = 'POST'
        Body        = $RequestBody
        ContentType = 'application/json'
        SkipCertificateCheck = $SkipCertificateCheck
    }

    $authRequest = Invoke-RestMethod @InvokeRestMethodParam


    $Instance = [PSCustomObject]@{
        Domain = $Uri
        auth   = $authRequest.jwt
        SkipCertificateCheck = $SkipCertificateCheck
    }
    $global:__LemmyInstance = $Instance

    if ($PassThru) {
        $Instance
    }
    else {
        Write-Output "Connected to $($Instance.Domain)"
    }
}
