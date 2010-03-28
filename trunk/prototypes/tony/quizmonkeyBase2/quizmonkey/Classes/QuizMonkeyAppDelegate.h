//
//  QuizMonkeyAppDelegate.h
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 2/15/10.
//
//  Worked on by Cley, Ariel, Tony, Meiko, Daniel
//
//  Known Bugs: none
//
//  Changes:
//   - 1.0 - Implemented
//
//  Copyright 2010 Team Awesome. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuizMonkeyViewController;

@interface QuizMonkeyAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    QuizMonkeyViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet QuizMonkeyViewController *viewController;

@end

