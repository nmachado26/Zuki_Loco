# Zuki - Stanford HCI Lab

Working on iOS version of WhoIsZuki. This repo is for quick prototyping to test different ideas, and therefore it was built upon the Arc Mini app to adopt some transportation classification functionality quickly and seamlessly. Arc Mini files are condensed in one folder, with Zuki work in the rest. 

Build identifiers, naming conventions, etc are still adopted from Arc Mini.

Instructions to run (from Arc):

1. `pod install`
2. Open the Xcode workspace -> the `Pods` project -> the `Upsurge` target, `Build Settings`, change the `Swift Language Version` to 4.2.
3. Add a new plist to the project, named `Config.plist`.
4. Add these string properties to the plist, using the corresponding values from your Foursquare/Last.fm developer accounts: 
    - `FoursquareClientId`
    - `FoursquareClientSecret`

The app will work without the Foursquare config vars, but place lookups will fail, so you will be unable to assign venues to visits. 
