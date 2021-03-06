/* * Copyright 2014-2015 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 * http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */


#import "HomePageViewController.h"

/**
 *  A static homepage for the app
 *
 *  Contains the app name and version number
 */
@interface HomePageViewController ()
@property UILabel *homepageTitle;
@property UILabel *versionNumber;
@end

static NSString* const HOME_PAGE_TITLE = @"AWS Device Farm Sample app";
static NSString* const HOME_PAGE_VERSION_NUMBER = @"Version 1";
static NSString* kFilename = @"TestFile.txt";

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

/**
 *  Configures and creates view
 */
-(void)setUpView{
    _homepageTitle = [[UILabel alloc] initWithFrame:[self frameFromCGPoint:CGPointMake(0, [self getTopPositionRounded] + [self getSmallHeightPadding]) AndCGSize:CGSizeMake([self getWidthMinusLargePadding], 0)]];
    
    _versionNumber = [[UILabel alloc] initWithFrame:[self frameFromCGPoint:CGPointZero AndCGSize:CGSizeMake([self getWidthMinusLargePadding], 0)]];
    
    [self configureLabel:_homepageTitle withText:HOME_PAGE_TITLE];
    [self configureLabel:_versionNumber withText:HOME_PAGE_VERSION_NUMBER];

    [self centerViewByWidth:_versionNumber];
    [self centerViewByWidth:_homepageTitle];

    [self putView:_versionNumber belowView:_homepageTitle withPadding:[self getSmallHeightPadding]];
    
    [self.view addSubview:_homepageTitle];
    [self.view addSubview:_versionNumber];
    
    //create file to export
    //create file contents
    NSString *data = @"Put this in a file please.";
    
    //get documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths lastObject];
    
    //create file path
    NSString *filepath = [documentsDirectory stringByAppendingPathComponent:kFilename];
    
    NSLog(@"Filepath: %@", filepath);
    
    BOOL success = [data writeToFile:filepath atomically:YES]; //Write the file
    if (!success) {
        NSLog(@"Error writing to file");
    }

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
    
    
    
}

/**
 *  Configures label
 *
 *  @param label   the label to configure
 *  @param content the content of the label
 */
-(void)configureLabel:(UILabel*)label withText:(NSString*)content{
    label.font = [UIFont largeBoldFont];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = content;
    [label sizeToFit];
}

@end
