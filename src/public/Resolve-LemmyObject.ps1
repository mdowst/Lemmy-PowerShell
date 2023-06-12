Function Resolve-LemmyObject {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Q


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: resolveObject
    #>
    param(
		[string]$Q
)
   
    	$RequestParameters = @{
		q = $Q
}

    Invoke-LemmyRestMethod -Uri '/resolve_object' -Method 'GET' -RequestParameters $RequestParameters
}
