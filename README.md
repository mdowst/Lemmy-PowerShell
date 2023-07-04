# Lemmy
This is a PowerShell module for interacting with the federated social media platform Lemmy.

# Installation
This module is still in alpha test, so only the preivew version has been published to the PowerShell Gallery. 
```PowerShell
Install-Module Lemmy-preview
Import-Module Lemmy-preview
```

You can also download and use it directly from the repository.
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

# Search Tools
There are several function to search for posts, comments, communities, and users in Lemmy.

## Find Posts
Use the function `Get-LemmyPost` to search for and return Lemmy posts.

### Example: Get all posts in a community
Returns a the posts in the community 'MyCommunity'
```PowerShell
Get-LemmyPost -CommunityName 'MyCommunity'
```

### Example: Search all posts in a community for a string
Searches for a post with the title 'Hello Lemmy' in the community 'MyCommunity'
```PowerShell
Get-LemmyPost -CommunityName 'MyCommunity' -SearchString 'Hello Lemmy'
```

### Example: Sort the results
Returns a the posts in the community 'MyCommunity' sorted by new.
```PowerShell
Get-LemmyPost -CommunityName 'MyCommunity' -Sort 'New'
```
Valid sort objects include 'Active', 'Hot', 'MostComments', 'New', 'NewComments', 'Old', 'TopAll', 'TopDay', 'TopMonth', 'TopWeek', 'TopYear'

## Find Comments
It is recommended that you filter it down to the post itself first, then search the comments.

### Example: Get all comments in post
Searches for a post with the title 'Hello Lemmy' in the community 'MyCommunity' then gets the comments for the post
```PowerShell
$post = Get-LemmyPost -CommunityName 'MyCommunity' -SearchString 'Hello Lemmy'
Get-LemmyComment -PostId $post.post.id
```

### Example: Get all top-level comments in post
Get the top-level comments
```PowerShell
$post = Get-LemmyPost -CommunityName 'MyCommunity' -SearchString 'Hello Lemmy'
Get-LemmyComment -PostId $post.post.id -MaxDepth 1
```

### Exmaple: Search comments with specific text 
Use the SearchString parameter to search the text inside a comment
```PowerShell
$post = Get-LemmyPost -CommunityName 'MyCommunity' -SearchString 'Hello Lemmy'
Get-LemmyComment -PostId $post.post.id -SearchString 'bad comment'
```

## Find Users
The function `Get-LemmyPerson` can be used to find a specific user account in Lemmy.
```PowerShell
Get-LemmyPerson -UserName 'pwshtester'
```


# Moderator Tools
This module contains functions to allow you to moderate your Lemmy communities.

## Remove a post
You can use `Remove-LemmyPost` to remove a post from a community. You must have the ID of the post. 
You can find the ID using `Get-LemmyPost` or by looking in the post URL. For example, the ID for post with the URL https://programming.dev/post/34958 is 34958.

### Examples
Searches for a post with the title 'Hello Lemmy' in the community 'MyCommunity' then removed the post
```PowerShell
$post = Get-LemmyPost -CommunityName 'MyCommunity' -SearchString 'Hello Lemmy'
Remove-LemmyPost -PostId $post.post.id -Reason 'breaking rule 1'
```

## Remove a comment
You can use `Remove-LemmyComment` to remove a comment from a post in your community. You must have the ID of the comment to remove. 

You can find a comment by searching based on the content of the comment. 
It is recommended that you filter it down to the post itself first, then search the comments.
 

### Examples
Searches for a post with the title 'Hello Lemmy' in the community 'MyCommunity', then gets the comment with the text 'A naughty comment', then removes the comment.
```PowerShell
$post = Get-LemmyPost -CommunityName 'MyCommunity' -SearchString 'Hello Lemmy'
$comment = Get-LemmyComment -PostId $post.post.id -SearchString 'A naughty comment'
Remove-LemmyComment -CommentId $comment.comment.id
```

The link button you see on the Lemmy site will only give you the ID of the top level comment.
But you can use that to narrow your search to the child comments and find the one you want to remove.
```PowerShell
$comment = Get-LemmyComment -PostId 1234 -ParentID 5 -SearchString 'A naughty comment'
Remove-LemmyComment -CommentId $comment.comment.id
```

## Lock and Unlock a post
You can use `Lock-LemmyPost` and `Unlock-LemmyPost` functions to lock and unlock post. You must have the ID of the post.

### Examples
Lock a post
```PowerShell
Lock-LemmyPost -PostId 1234
```

Unlock a post
```PowerShell
Unlock-LemmyPost -PostId 1234
```

