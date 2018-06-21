# This is a fork to help reproduce an issue with the customer artifacts feature of Device Farm. 

after making [this method](https://github.com/jamesknowsbest/aws-device-farm-xctest-ui-tests-for-ios-sample-app/blob/master/ADFiOSReferenceAppUITests/AlertsTest.m#L62-L79) to create a file in the application sandbox Documents directory I am unable to export it given the option in the web console

### Local execution's filepath: 

![local execution's path](https://imgur.com/VYdcF4G)

### specify device state page | reference to export the file created during the test: 

![specify device state page](https://imgur.com/p2FHrcx)

### Customer artifacts log after executing in Device Farm: 
```
Now attempting to pull iOS customer files from Documents/TestFile.txt
Failed to attach files from the device path: Documents/TestFile.txt
Now attempting to pull host machine customer files from $WORKING_DIRECTORY
Failed to attach directory $WORKING_DIRECTORY because it is empty
No files were attached.
```

### [Info.plist file](https://github.com/jamesknowsbest/aws-device-farm-xctest-ui-tests-for-ios-sample-app/blob/master/ADFiOSReferenceAppUITests/Info.plist): 


# XCTestUI Sample Tests for AWS Device Farm iOS Sample App

This is an XCTest UI test suite that tests some basic functionalities of the AWS Device Farm iOS [sample app](https://github.com/awslabs/aws-device-farm-sample-app-for-ios).

## Getting Started
In order to run this app within Device Farm you will need to create a local copy of this repository and build the application from source.

#### Building Project with Xcode 7
1. Select the `AWSDeviceFarmiOSReferenceApp` target.
2. Select `Generic iOS Device` as our build target.
3. Click `Product > Build For > Testing`.

#### Packing and Creating XCTest UI Test Runner
1. Go into your build directory: ```~/Library/Developer/Xcode/DerivedData/ProjectName/Build/Products/Debug-iphoneos``` or if you have a custom build directory, go to that location.
2. Create a new directory named "Payload"
3. Move the "*-Runner.app" file into the "Payload" folder
4. Right click the Payload folder > Compress.
5. Rename "Payload.zip" to "test_runner.ipa".

## Testing on Device Farm
Follow the steps in the official AWS Device Farm documentation for [XCTest UI Testing](http://docs.aws.amazon.com/devicefarm/latest/developerguide/test-types-ios-xctest-ui.html). 
