Function Test-LemmyConnection{
    if(-not $Global:__LemmyInstance){
        throw "Run Connect-LemmyInstance to connect to a Lemmy instance"
    }
}