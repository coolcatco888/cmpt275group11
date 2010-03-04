//
//  QuizMonkeyViewController.h
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 2/15/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizMonkeyViewController : UIViewController {
	IBOutlet UIButton *btn_Play;
	IBOutlet UIButton *btn_Quit;
	IBOutlet UIImageView *img_Monkey;
	IBOutlet UIView *vew_Question;
	IBOutlet UIView *vew_MainView;
	IBOutlet UILabel *lbl_Question;
	NSArray *ThisArray;
	IBOutlet UIButton *btn_New;
	IBOutlet UILabel *lbl_New;
	UIAlertView *alr_Alert;
}

-(IBAction)ShowAlert:(id)sender;
-(IBAction)NewButton:(id)sender;
-(IBAction)TapPlay:(id)sender;
-(IBAction)TapQuit:(id)sender;
-(IBAction)ExitQuestion:(id)sender;
-(IBAction)Change_Button:(id)sender;
-(IBAction)Change_Picture:(id)sender;
-(IBAction)LoadArray:(id)sender;
-(IBAction)SetQuestion:(id)sender;

@end

