# Lemmy
This is a PowerShell module for interacting with the federated social media platform Lemmy.


# Installation
This module is still in alpha test, so it has not be published to the PowerShell Gallery. To install you must download this repository.
```
git clone https://github.com/mdowst/Lemmy-PowerShell.git
Import-Module .\Lemmy-PowerShell\src\Lemmy.psd1
```

# Connecting to an Instance
Run `Connect-LemmyInstance` to connect and authenticate with an instance of Lemmy.

Username is either your username on the instance or you email address.

```PowerShell
$credential = Get-Credential
Connect-LemmyInstance -Uri 'https://programming.dev/' -Credential $credential
```
