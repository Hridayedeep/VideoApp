# VideoApp

This Video App is a simple implementation of a list of some public videos(.mp4s) which are shown on the UI and upon clicking them, user is taken to the next page to show a full screen player, where the video is ultimately played
1. This also has a built-in caching support, where the iPhone device would be able to play the video if the asset already exists in the cache. else, it will fetch then play the video.
2. The app also supports deeplinking (URL scheme based), where we can use a similar URL like this - com.videoapp://something. the action would be opening up of the Video App and ultimately shwing a popup that contains the URL info of the deeplink.
