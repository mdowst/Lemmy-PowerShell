Function Find-LemmyPerson{
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
        $UserName
    )

    $search = Search-Lemmy -Type 'Users' -Q $username
    $search | Where-Object{ $_.person } | Select-Object -ExpandProperty person
}