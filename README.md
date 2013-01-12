# InterwebzSample

This is the application i used to demonstrate during "Testing in iOS" keynote.

## Running the app

This application manages dependent libraries through CocoaPods. If you haven't used CocoaPods, please see their [website](http://cocoapods.org/).

1. Clone the repo
2. Run `pod install` in your cloned repository.
3. Open the project using freshly created InterwebzSample.xcworkspace file.
4. Change `HEADER_SEARCH_PATHS = ${PODS_HEADERS_SEARCH_PATHS}` to `HEADER_SEARCH_PATHS = ${inherited} ${PODS_HEADERS_SEARCH_PATHS}` in Pods-InterwebzSampleTests.xcconfig file.
5. Build and run!
