Function Remove-LemmyPostAdmin {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Deleted

	.PARAMETER PostId


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: deletePost
    #>
    param(
		[boolean]$Deleted,
		[int]$PostId
)
   
    	$RequestParameters = @{
		deleted = $Deleted
		post_id = $PostId
}

    Invoke-LemmyRestMethod -Uri '/post/delete' -Method 'POST' -RequestParameters $RequestParameters
}
