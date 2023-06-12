Function Get-LemmySiteMetadata {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Url


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: getSiteMetadata
    #>
    param(
		[string]$Url
)
   
    	$RequestParameters = @{
		url = $Url
}

    Invoke-LemmyRestMethod -Uri '/post/site_metadata' -Method 'GET' -RequestParameters $RequestParameters
}
