//
//  SubmissionViewController.m
//  QuizMonkey
//
//  Created by Tony Yang on 3/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SubmissionViewController.h"


@implementation SubmissionViewController
@synthesize submitView;
@synthesize submitButton;
@synthesize continueButton;
@synthesize studentID_tf;
@synthesize password_tf;
//@synthesize submitScore;


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
- (IBAction)loadSubmissionView:(id)sender {
	[mainMenuView addSubview:submitView];
}

- (IBAction)submitScore {
	submitScore = [Score new];
	[studentID_tf resignFirstResponder];
	[password_tf resignFirstResponder];

	[submitScore setStudentID:[studentID_tf text]];
	[submitScore setPassword:[password_tf text]];
	[submitScore setDate:[NSDate date]];
}

- (IBAction)clickContinue{
	[submitView removeFromSuperview];
}

-(BOOL)textFieldShouldReturn:(UITextField *) theTextField {
	[theTextField resignFirstResponder];
	return TRUE;
}
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
