//
//  QuizMonkeyAppDelegate.h
//  QuizMonkey
//
//  Created by Cley on 12/02/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

@interface QuizMonkeyAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

