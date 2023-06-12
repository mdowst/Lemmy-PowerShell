Function Lock-LemmyPost {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Locked

	.PARAMETER PostId


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: lockPost
    #>
    param(
		[boolean]$Locked,
		[int]$PostId
)
   
    	$RequestParameters = @{
		locked = $Locked
		post_id = $PostId
}

    Invoke-LemmyRestMethod -Uri '/post/lock' -Method 'POST' -RequestParameters $RequestParameters
}
