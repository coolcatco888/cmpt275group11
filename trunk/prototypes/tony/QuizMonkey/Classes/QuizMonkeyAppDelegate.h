//
//  QuizMonkeyAppDelegate.h
//  QuizMonkey
//
//  Created by yang qiong on 2/13/10.
//  Copyright sfu 2010. All rights reserved.
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

