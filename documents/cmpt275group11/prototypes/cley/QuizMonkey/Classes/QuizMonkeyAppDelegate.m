//
//  QuizMonkeyAppDelegate.m
//  QuizMonkey
//
//  Created by Cley on 12/02/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "QuizMonkeyAppDelegate.h"
#import "RootViewController.h"


@implementation QuizMonkeyAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

