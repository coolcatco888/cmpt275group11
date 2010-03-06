//
//  UnitTest1AppDelegate.m
//  UnitTest1
//
//  Created by Tony Yang on 3/5/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "UnitTest1AppDelegate.h"
#import "UnitTest1ViewController.h"

@implementation UnitTest1AppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
