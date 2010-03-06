//
//  UnitTest1AppDelegate.h
//  UnitTest1
//
//  Created by Tony Yang on 3/5/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UnitTest1ViewController;

@interface UnitTest1AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UnitTest1ViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UnitTest1ViewController *viewController;

@end

