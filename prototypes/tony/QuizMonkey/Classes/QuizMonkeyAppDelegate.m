//
//  QuizMonkeyAppDelegate.m
//  QuizMonkey
//
//  Created by yang qiong on 2/13/10.
//  Copyright sfu 2010. All rights reserved.
//

#import "QuizMonkeyAppDelegate.h"
#import "QuizMonkeyViewController.h"

@implementation QuizMonkeyAppDelegate

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
