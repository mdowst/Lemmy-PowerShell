Function Approve-LemmyRegistrationApplication {
    <#
    .SYNOPSIS
    Call Lemmy API

	.PARAMETER Approve

	.PARAMETER DenyReason

	.PARAMETER Id


    .EXAMPLE
    An example
    
    .NOTES
    Lemmy API class: approveRegistrationApplication
    #>
    param(
		[boolean]$Approve,
		[string]$DenyReason,
		[int]$Id
)
   
    	$RequestParameters = @{
		approve = $Approve
		deny_reason = $DenyReason
		id = $Id
}

    Invoke-LemmyRestMethod -Uri '/admin/registration_application/approve' -Method 'PUT' -RequestParameters $RequestParameters
}
