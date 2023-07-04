# Script variables
$Release = 'preview'
$IncludeDirectories = 'Admin','Private','Public','Mod'
$SourcePath = (Split-Path $PSScriptRoot)
$ModulesFolder = Join-Path $SourcePath 'src'

$NugetAPIKey = Get-Content (Join-Path $SourcePath '\.build\APIKey')

# Get the module manifest
$psd1File = Get-ChildItem -path $ModulesFolder -Filter "*.psd1"
$psm1File = Get-ChildItem -path $ModulesFolder -Filter "*.psm1"
$psd1 = Test-ModuleManifest $psd1File.FullName
$Version = $psd1.Version

# create the release folder
$releaseFolder = Join-Path $SourcePath "\.build\$($psd1)-$($release)\$($Version.ToString())"
If (-not(Test-Path $releaseFolder)){
    New-Item -type Directory -Path $releaseFolder | Out-Null
}
else{
    Get-ChildItem $releaseFolder | Remove-Item -Recurse -Force
}

# Copy files to release folder
$psd1Copy = Copy-Item -LiteralPath $psd1File.FullName -Destination $releaseFolder -PassThru -Force
$psm1Copy = Copy-Item -LiteralPath $psm1File.FullName -Destination $releaseFolder -PassThru -Force
if($Release -eq 'preview'){
    $psm1Copy | Rename-Item -NewName "$($psm1File.BaseName)-preview.psm1"
    $psd1File = $psd1Copy | Rename-Item -NewName "$($psm1File.BaseName)-preview.psd1" -PassThru
    $psd1Content = Get-Content -LiteralPath $psd1File.FullName | ForEach-Object{ $_.Replace('Lemmy.psm1','Lemmy-preview.psm1') }
    $psd1Content | Out-File -FilePath $psd1File.FullName -Encoding utf8
}

foreach($folder in $IncludeDirectories){
    $modFolder = Join-Path $ModulesFolder $folder
    $destFolder = Join-Path $releaseFolder $folder
    If (-not(Test-Path $destFolder)){
        New-Item -type Directory -Path $destFolder | Out-Null
    }

    Get-ChildItem $modFolder -File | Copy-Item -Destination $destFolder
}


# Publish to powershell gallery
#Publish-Module -Path $releaseFolder -NugetAPIKey $NugetAPIKey -Verbose