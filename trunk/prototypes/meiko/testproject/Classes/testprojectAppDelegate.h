//
//  testprojectAppDelegate.h
//  testproject
//
//  Created by Meiko on 10-02-12.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

@interface testprojectAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

