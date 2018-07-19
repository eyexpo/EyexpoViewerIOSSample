# Eyexpo Viewer IOS Sample

This is a code sample to view Eyexpo Pro virtual [tour builder](https://stage.eyexpo.com/) in native iOS app.

In order to use this app you would need an authorized account on our [tour builder](https://stage.eyexpo.com/) website.

This app only shows your "public" tours. Under the hood the app utilizes their native web viewer to see the tour.

Download and run `pod install` and open `eyexpopronative.xcworkspace` with your XCode.


## Under the hood

The app utilizes our EyexpoPro [API](https://stage.eyexpo.com/api/documentation)

The iOS implementation for most of the network calls can be seen over at [NetworkManager.swift](https://github.com/eyexpo/EyexpoViewerIOSSample/blob/master/eyexpopronative/NetworkManager.swift)

The API `getPublicTours` will return `Tour` [json](https://github.com/eyexpo/EyexpoViewerIOSSample/blob/master/eyexpopronative/Model/Tour.swift) response.
`cover_img_thumbnail` contains the image URL to display the cover image.
`public_url` is the URL for the the virtual tour.

The native viewer for the iOS for the virtual tour is using Apple's `WKWebView`, you can see on the [WebViewController.swift](https://github.com/eyexpo/EyexpoViewerIOSSample/blob/master/eyexpopronative/WebViewController.swift) for more details.

To view a single 360 image we recommend using the [GVRSDK](https://github.com/googlevr/gvr-ios-sdk)

If you have any questions you can email to us at [developers@eyexpo.co](mailto:developers@eyexpo.co)

