//
//  QuizMonkeyAppDelegate.h
//  QuizMonkey
//
//  Created by Cley Tang on 2/15/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
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

