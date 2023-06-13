Function Set-LemmyFeaturePost {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER FeatureType

	.PARAMETER Featured

	.PARAMETER PostId


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: featurePost
    #>
    param(
				[ValidateSet('Community','Local')]
		[string]$FeatureType,
		[boolean]$Featured,
		[int]$PostId
)
   
    	$RequestParameters = @{
		feature_type = $FeatureType
		featured = $Featured
		post_id = $PostId
}

    Invoke-LemmyRestMethod -Uri '/post/feature' -Method 'POST' -RequestParameters $RequestParameters
}
