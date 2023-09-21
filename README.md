
# VideoApp

This Video App is a simple implementation of a list of some public videos(.mp4s) which are shown on the UI and upon clicking them, user is taken to the next page to show a full screen player, where the video is ultimately played
1. This also has a built-in caching support, where the iPhone device would be able to play the video if the asset already exists in the cache. else, it will fetch then play the video.
- On the home page, to check whethe the video is cache'd or not, there is an icon placement on the right for every title, if the video is downloaded, we'll see a tickmark, else a download icon.
3. The app also supports deeplinking (URL scheme based), where we can use a similar URL like this - com.videoapp://something. the action would be opening up of the Video App and ultimately shwing a popup that contains the URL info of the deeplink.

Screenshots:
![Screen Shot 2023-09-21 at 12 46 57 PM](https://github.com/Hridayedeep/VideoApp/assets/26848286/22e52c4b-16c6-4692-be18-f09892b839a1)
![Screen Shot 2023-09-21 at 12 46 52 PM](https://github.com/Hridayedeep/VideoApp/assets/26848286/21ebdfcb-187b-410d-92d5-b25ca5ba9980)
![Screen Shot 2023-09-21 at 12 46 37 PM](https://github.com/Hridayedeep/VideoApp/assets/26848286/5199337f-58d3-49ba-b496-30a1b060963f)
![Screen Shot 2023-09-21 at 12 46 28 PM](https://github.com/Hridayedeep/VideoApp/assets/26848286/7cdad855-953f-4133-a6a6-1187360957f9)
