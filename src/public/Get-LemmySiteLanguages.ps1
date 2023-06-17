Function Get-LemmySiteLanguages {
    <#
    .SYNOPSIS
    Call Lemmy API

    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: getSite
    #>
    param()
   
    

    $site = Get-LemmySite
    $site | Where-Object{ $_.id -ge 0 } 
}
