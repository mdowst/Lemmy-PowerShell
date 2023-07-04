Function Connect-LemmyInstance {
    <#
    .SYNOPSIS
    Use to authenticate to a Lemmy Instance.
    
	.PARAMETER Instance
    The URI of the lemmy instance

	.PARAMETER Credential
    A credential object with the username and password. Will be prompted if not supplied.

    .PARAMETER PageLimit
    The number of results to return for each call

    .PARAMETER ApiVersion
    The Lemmy api version to use. Default to v3. You should not need to change this.

    .PARAMETER SkipCertificateCheck
    Use to skip certificate checks. Should only be used if you know what you are doing with it.

    .EXAMPLE
    An example
    
    .NOTES
    General notes
    #>
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$true)]
        [Alias('Uri','Site')]
        [string]$Instance,
        [parameter(Mandatory=$false)]
        [pscredential]$Credential,
        [parameter(Mandatory=$false)]
        [string]$ApiVersion = 'v3',
        [parameter(Mandatory=$false)]
        [string]$PageLimit = 50,
        [parameter(Mandatory=$false)]
        [switch]$SkipCertificateCheck=$false
    )

    if(-not $PSBoundParameters['Credential']){
        $Credential = Get-Credential
    }

    $RequestBody = @{
        password          = $credential.GetNetworkCredential().Password
        username_or_email = $Credential.UserName
    } | ConvertTo-Json
    
    if($Instance -notmatch 'https://'){
        $Instance = 'https://' + $Instance 
    }
    $Instance = $Instance -replace ('/$', '')
    
    $InvokeRestMethodParam = @{
        Uri         = "$($Instance)/api/$($ApiVersion)/user/login"
        Method      = 'POST'
        Body        = $RequestBody
        ContentType = 'application/json'
        SkipCertificateCheck = $SkipCertificateCheck
    }

    $authRequest = Invoke-RestMethod @InvokeRestMethodParam


    $LemmyInstance = [PSCustomObject]@{
        Domain = $Instance
        auth   = $authRequest.jwt
        SkipCertificateCheck = $SkipCertificateCheck
        Api = $ApiVersion
        PageLimit = $PageLimit
    }
    $global:__LemmyInstance = $LemmyInstance

    
    Write-Output "Connected to $($global:__LemmyInstance.Domain)"
}
