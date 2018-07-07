# This is a fork to help reproduce an issue with the customer artifacts feature of Device Farm. 

after making [this method](https://github.com/jamesknowsbest/aws-device-farm-xctest-ui-tests-for-ios-sample-app/blob/master/ADFiOSReferenceAppUITests/AlertsTest.m#L62-L79) to create a file in the application sandbox Documents directory I am unable to export it given the option in the web console

### Local execution's filepath: 

![local execution's path](https://i.imgur.com/VYdcF4G.png)

### file's output after the test executes

```
cat /Users/$(whoami)/Library/Developer/CoreSimulator/Devices/71D0EC78-7912-4361-B850-C1109751C4A5/data/Containers/Data/Application/D2D54BB6-1E39-4115-9259-091ADD839539/Documents/TestFile.txt
Put this in a file please.
```

### specify device state page | reference to export the file created during the test: 

![specify device state page](https://i.imgur.com/p2FHrcx.png)

### Customer artifacts log after executing in Device Farm: 
```
Now attempting to pull iOS customer files from Documents/TestFile.txt
Failed to attach files from the device path: Documents/TestFile.txt
Now attempting to pull host machine customer files from $WORKING_DIRECTORY
Failed to attach directory $WORKING_DIRECTORY because it is empty
No files were attached.
```

### [Info.plist file](https://github.com/jamesknowsbest/aws-device-farm-xctest-ui-tests-for-ios-sample-app/blob/master/ADFiOSReferenceAppUITests/Info.plist): 

### Device Farm execution URL: 

`https://us-west-2.console.aws.amazon.com/devicefarm/home?#/projects/05544254-5ed2-4409-ba27-b59fe5d71dd7/runs/b9d127a7-c1f2-470b-9721-77e775a9d6f7/jobs/00000`

### Extra data feature failure

After modifiying the application here to log out the file structure, the aatp/data directory is not found with an extra data zip uploaded. 

**URL:** https://us-west-2.console.aws.amazon.com/devicefarm/home?#/projects/653bfd19-f142-4e28-86b6-663aedce5026/runs/dc5e8da8-78ce-4af0-bb38-4b0208f0db43/jobs/00000

**Syslog statements:**
```
Jul  6 19:35:33 9902855732 AWSDeviceFarmiOSReferenceApp[301] <Notice>: 20.000000
Jul  6 19:35:33 9902855732 AWSDeviceFarmiOSReferenceApp[301] <Notice>: Directory - Documents
Jul  6 19:35:33 9902855732 kernel(Sandbox)[0] <Notice>: SandboxViolation: AWSDeviceFarmiOS(301) deny(1) file-read-metadata /private/var/mobile/Containers/Data/Application/F84662DA-CEA4-4FBF-BCB4-5941A7B99FE3/.com.apple.mobile_container_manager.metadata.plist
Jul  6 19:35:33 9902855732 AWSDeviceFarmiOSReferenceApp[301] <Notice>: Directory - Library
Jul  6 19:35:33 9902855732 AWSDeviceFarmiOSReferenceApp[301] <Notice>: Directory - Library/Caches
Jul  6 19:35:33 9902855732 AWSDeviceFarmiOSReferenceApp[301] <Notice>: Directory - Library/Preferences
Jul  6 19:35:33 9902855732 AWSDeviceFarmiOSReferenceApp[301] <Notice>: Directory - tmp
```

**Code being used to reference the files:** https://github.com/jamesknowsbest/aws-device-farm-xctest-ui-tests-for-ios-sample-app/blob/master/ADFiOSReferenceApp/HomePageViewController.m#L57-L84

```
//source: http://iosdevelopertips.com/data-file-management/list-files-in-directory-and-all-subdirectores.html
    NSFileManager *fileMgr;
    NSString *entry;
    NSString *documentsDir;
    NSDirectoryEnumerator *enumerator;
    BOOL isDirectory;
    
    // Create file manager
    fileMgr = [NSFileManager defaultManager];
    
    // Path to documents directory
    documentsDir = NSHomeDirectory();
    
    // Change to Documents directory
    [fileMgr changeCurrentDirectoryPath:documentsDir];
    
    // Enumerator for docs directory
    enumerator = [fileMgr enumeratorAtPath:documentsDir];
    
    // Get each entry (file or folder)
    while ((entry = [enumerator nextObject]) != nil)
    {
        // File or directory
        if ([fileMgr fileExistsAtPath:entry isDirectory:&isDirectory] && isDirectory)
            NSLog (@"Directory - %@", entry);
        else
            NSLog (@"  File - %@", entry);
}
```

How do you access the additional files from the extra data feature? I know they're in the `aatp/data` directory([reference](https://forums.aws.amazon.com/thread.jspa?threadID=252143)) but that doesn't appear to be found using the above code and the application's sandbox home directory. Is there somewhere else to look? 


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
