$cmdletMapping = Import-Csv (Join-Path $PSScriptRoot 'lemmyApiCmdletMappings.csv')

# Scrap the Lemmy API documents
$LemmyHttp = ConvertFrom-Html -URI 'https://join-lemmy.org/api/classes/LemmyHttp.html'
$xPath = '/html/body/div[1]/div/div[1]/section[6]'
$methods = $LemmyHttp.SelectNodes($xPath)
$elements = $methods.ChildNodes | Where-Object { $_.NodeType -eq 'Element' -and $_.Name -eq 'section' }


$apiClasses = foreach ($e in $elements) {
    $class = $e.ChildNodes[3].InnerText
    Write-Host $class

    if ($class -match '^Private') { continue }
    $classInfo = [pscustomobject]@{
        class       = $class
        description = $null
        uri         = $null
        method      = $null
        Parameters  = $null
        cmdlet      = $null
    }
    $classdets = $e.ChildNodes[7].ChildNodes[1].ChildNodes[3].ChildNodes[3].ChildNodes[0].InnerText
    $classInfo.uri = $classdets.Substring($classdets.IndexOf(' ')).Trim()
    $classInfo.method = $classdets.Substring(5, $classdets.IndexOf(' ') - 5).Trim()
    $classInfo.description = $e.ChildNodes[7].ChildNodes[1].ChildNodes[3].ChildNodes[1].ChildNodes[1].InnerText
    $link = $null
    if ($e.ChildNodes[7].ChildNodes[1].ChildNodes[7].ChildNodes) {
        $link = $e.ChildNodes[7].ChildNodes[1].ChildNodes[7].ChildNodes[1].ChildNodes[1].ChildNodes[1].Attributes | Where-Object { $_.Name -eq 'href' }
    }
    if ($link.Value -match 'interfaces') {
        $interface = ConvertFrom-Html -URI $link.Value.Replace('..', 'https://join-lemmy.org/api')
        $interfaceXPath = '//*[@class="tsd-signature tsd-kind-icon"]'
        $PropertyNodes = $interface.SelectNodes($interfaceXPath)
        #$interfaceXPath = '/html/body/div[1]/div/div[1]/section[3]'
        #$PropertyElemenets = $PropertyNodes.ChildNodes | Where-Object { $_.NodeType -eq 'Element' -and $_.Name -eq 'section' }
        $classInfo.parameters = foreach ($p in $PropertyNodes) {
            $enumType = $p.ChildNodes | Where-Object{ $_.Name -eq 'a' }
            $enumLink = $enumType.Attributes | Where-Object { $_.Name -eq 'href' }
            $ValidateSet = $null
            if($enumLink.Value){
                $enumData = ConvertFrom-Html -URI $enumLink.Value.Replace('..', 'https://join-lemmy.org/api')
                $enumXPath = '//*[@class="tsd-anchor"]'
                $validSet = $enumData.SelectNodes($enumXPath) | Foreach-Object{
                    ($_.Attributes | Where-Object{ $_.Name -eq 'name' }).Value
                }
                $ValidateSet = "'$($validSet -join("','"))'"
            }
            $propValues = $p.InnerText
            [pscustomobject]@{
                Parameter = $propValues.Split(':')[0].Trim()
                Type      = $propValues.Split(':')[1].Trim()
                ValidateSet = $ValidateSet
            }
        }
    }
    $classInfo.cmdlet = ($cmdletMapping | Where-Object{ $_.Class -eq $class }).cmdlet
    $classInfo
}




$path = Join-Path (Split-Path $PSScriptRoot) 'src\public'
foreach($ac in $apiClasses | Where-Object{ $_.class -ne 'login'}){
    $ParamHelp = ''
    $ParamBlock = ''
    $ParamMap = ''
    $ParamPass = ''
    if($ac.Parameters | Where-Object{ $_.Parameter -ne 'auth' -and $_ }){
        $params = @()
        $helpParam = @()
        $mapParam = @()
        $ac.Parameters | Where-Object{ $_.Parameter -ne 'auth' -and $_ } | ForEach-Object{
            $name = $_.Parameter.Split('_') | Where-Object{ $_ } | ForEach-Object{ $_.Substring(0,1).ToUpper() + $_.Substring(1) }
            $type = $_.Type
            $vs = $null
            if($_.Type -eq 'number'){
                $type = 'int'
            }
            elseif($_.ValidateSet){
                $type = 'string'
                $vs = "`t`t[ValidateSet($($_.ValidateSet))]"
            }
            if($vs){
                $params += "`t`t$($vs)`n`t`t[$($Type)]`$$($name -join(''))"
            }else{
                $params += "`t`t[$($Type)]`$$($name -join(''))"
            }
            $helpParam += "`t.PARAMETER $($name -join(''))`n"
            $mapParam += "`t`t$($_.Parameter) = `$$($name -join(''))"
        }

        $ParamHelp = "`n$($helpParam -join("`n"))`n"
        $ParamMap = "`t`$RequestParameters = @{`n$($mapParam -join("`n"))`n}"
        $ParamBlock = "`n$($params -join(",`n"))`n"
        $ParamPass = '-RequestParameters $RequestParameters'
    }
    
@"
Function $($ac.cmdlet) {
    <#
    .SYNOPSIS
    Call Lemmy API
$ParamHelp
    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: $($ac.class)
    #>
    param($ParamBlock)
   
    $ParamMap

    Invoke-LemmyRestMethod -Uri '$($ac.Uri)' -Method '$($ac.method)' $ParamPass
}
"@ | Out-File -FilePath (Join-Path $path "$($ac.cmdlet).ps1") -Encoding utf8

}