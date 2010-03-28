//
//  QuizMonkeyAppDelegate.m
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 2/15/10.
//
//  Worked on by Cley, Ariel, Tony, Meiko, Daniel
//
//  Known Bugs: See the header file
//
//  Changes: See the header file
//
//  Copyright 2010 Team Awesome. All rights reserved.
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
