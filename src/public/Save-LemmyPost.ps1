Function Save-LemmyPost {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER PostId

	.PARAMETER Save


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: savePost
    #>
    param(
		[int]$PostId,
		[boolean]$Save
)
   
    	$RequestParameters = @{
		post_id = $PostId
		save = $Save
}

    Invoke-LemmyRestMethod -Uri '/post/save' -Method 'PUT' -RequestParameters $RequestParameters
}
