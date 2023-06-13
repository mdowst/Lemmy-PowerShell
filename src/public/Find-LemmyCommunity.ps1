Function Find-LemmyCommunity{
    <#
    .SYNOPSIS
    Find a Lemmy user
       
    .PARAMETER UserName
    All or part of the username
    
    .EXAMPLE
    Find-LemmyPerson -UserName 'pwshtester'
    
    .NOTES
    General notes
    #>
    param(
        $Name
    )

    $search = Search-Lemmy -Type 'Communities' -Q $Name
    $search | Where-Object{ $_.community } | Select-Object -ExpandProperty community
}