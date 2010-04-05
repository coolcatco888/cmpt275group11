//
//  SubmissionViewController.h
//  QuizMonkey
//
//  Created by Tony Yang on 3/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Score.h"
#import "WebInterface.h"

@interface SubmissionViewController : UIViewController {
	IBOutlet UIView *mainMenuView;
	IBOutlet UIView *submitView;//A reference to the submit score view
	
	IBOutlet UIButton *submitButton;
	IBOutlet UIButton *continueButton;
	IBOutlet UITextField *studentID_tf;
	IBOutlet UITextField *password_tf;
	
	Score *submissionScore;
	WebInterface *webInterface;

	

}
@property (assign) IBOutlet UIView *submitView;
@property (assign) IBOutlet UIButton *submitButton;
@property (assign) IBOutlet UIButton *continueButton;
@property (assign) IBOutlet UITextField *studentID_tf;
@property (assign) IBOutlet UITextField *password_tf;
@property (assign) Score *submissionScore;

-(IBAction)loadSubmissionView:(id)sender;
-(IBAction) submitScore;
-(IBAction) clickContinue;
@end

