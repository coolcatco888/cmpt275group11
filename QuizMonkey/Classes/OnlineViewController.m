//
//  OnlineViewController.m
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 3/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "OnlineViewController.h"


@implementation OnlineViewController

@synthesize submitScoreURL;
@synthesize highScoresURL;
@synthesize currentScore;

- init {
	scoreParser = [ScoreParser new];
	currentStudentID = @"";
	currentPassword = @"";
	submitScoreURL = [NSMutableString stringWithCapacity:255];
	highScoresURL = [NSMutableString stringWithCapacity:255];
	[submitScoreURL setString:@"http://quizmonkey.x10hosting.com/submit.php?"];
	[highScoresURL setString:@"http://quizmonkey.x10hosting.com/viewxml.php?"];
	[highScoresURL retain];
	[submitScoreURL retain];
	submitingScore = FALSE;
	gettingScores = FALSE;
	return self;
}
- (void)loadHighScoresFromURL {
	if (!gettingScores) {
		gettingScores = TRUE;
		[submitButton setTitle:@"Get Scores" forState:0];
		[mainMenuView addSubview:submitView];
	}
	else {
		[highScoresURL appendString:@"username="];
		[highScoresURL appendString:currentStudentID];
		[highScoresURL appendString:@"&password="];
		[highScoresURL appendString:currentPassword];
		NSLog(highScoresURL);
		highScoresData = [NSData dataWithContentsOfURL:[NSURL URLWithString:highScoresURL]];
		if([[[NSString alloc] initWithData:highScoresData encoding:NSUTF8StringEncoding] isEqualToString:@"FAILED"]) {
			[statusLabel setText:@"Invalid username or password"];
			[statusLabel setHidden:FALSE];
		}
		else {
			NSLog(@"%@",[[NSString alloc] initWithData:highScoresData encoding:NSUTF8StringEncoding]);
			highScoresArray = [scoreParser parseScoresFromData:highScoresData];
			for(int i = 0; i < 17 && i<[highScoresArray count]; i++) {
				currentScore = [highScoresArray objectAtIndex:i];
				NSString *studentID = [currentScore studentID];
				NSString *timeLeft = [[NSNumber numberWithInt:[currentScore timeLeft]] stringValue];
				NSString *points = [[NSNumber numberWithInt:[currentScore points]] stringValue];
				NSString *maxPoints = [[NSNumber numberWithInt:[currentScore maxPoints]] stringValue];
				[self newButtonInHighScoresSubView:studentID buttonX:0 buttonY:i*29 alignment:UIControlContentHorizontalAlignmentLeft];
				[self newButtonInHighScoresSubView:timeLeft buttonX:110 buttonY:i*29 alignment:UIControlContentHorizontalAlignmentCenter];
				[self newButtonInHighScoresSubView:points buttonX:220 buttonY:i*29 alignment:UIControlContentHorizontalAlignmentCenter];
				[self newButtonInHighScoresSubView:maxPoints buttonX:330 buttonY:i*29 alignment:UIControlContentHorizontalAlignmentRight];
			}
			[mainMenuView addSubview:highScoresView];
		}
	}
}
- (void)submitCurrentScore {
	if (!submitingScore){
		submitingScore = TRUE;
		[submitButton setTitle:@"Submit" forState:0];
		[mainMenuView addSubview:submitView];
	}
	else {
		[self appendVariableToSubmitionString:@"username" value:currentStudentID];
		[submitScoreURL appendString:@"&"];
		[self appendVariableToSubmitionString:@"password" value:currentPassword];
		[submitScoreURL appendString:@"&"];
		[self appendVariableToSubmitionString:@"timeleft" value:[[NSNumber numberWithInt:[currentScore timeLeft]] stringValue]];
		[submitScoreURL appendString:@"&"];
		[self appendVariableToSubmitionString:@"points" value:[[NSNumber numberWithInt:[currentScore points]] stringValue]];
		[submitScoreURL appendString:@"&"];
		[self appendVariableToSubmitionString:@"maxpoints" value:[[NSNumber numberWithInt:[currentScore maxPoints]]  stringValue]];
		NSLog(submitScoreURL);
		[NSData dataWithContentsOfURL:[NSURL URLWithString:submitScoreURL]];
	}
}
- (IBAction)submitScore {
	[studentID_tf resignFirstResponder];
	[password_tf resignFirstResponder];

	currentStudentID = [studentID_tf text];
	currentPassword = [password_tf text];
	
	if([self validUsernameAndPassword]){
		if(submitingScore) {
			[statusLabel setHidden:TRUE];
			[submitView removeFromSuperview];
			[self submitCurrentScore];
		}
		if(gettingScores) {
			[statusLabel setHidden:TRUE];
			[submitView removeFromSuperview];
			[self loadHighScoresFromURL];
		}
	}
}
- (IBAction)exitSubmitView {
	[submitView removeFromSuperview];
}
- (IBAction)exitHighScoresView {
	for(int i=0; i<[[highScoresSubView subviews] count];i++){
		[[[highScoresSubView subviews] objectAtIndex:i] setHidden:TRUE];
	}
	[highScoresView removeFromSuperview];
}
- (void)newButtonInHighScoresSubView:(NSString*)title buttonX:(CGFloat)buttonX buttonY:(CGFloat)buttonY alignment:(UIControlContentHorizontalAlignment)alignment {
	newButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[newButton setEnabled:FALSE];
	[newButton setTitle:title forState:0];
	[newButton setFrame:CGRectMake(buttonX, buttonY, 110, 21)];
	[newButton setContentHorizontalAlignment:alignment];
	[highScoresSubView addSubview:newButton];
}
- (void)appendVariableToSubmitionString:(NSString*)variable value:(NSString*)value {
	[submitScoreURL appendString:variable];
	[submitScoreURL appendString:@"="];
	[submitScoreURL appendString:value];
}
- (BOOL)validUsernameAndPassword {
	if([currentStudentID isEqualToString:@""]) return FALSE;
	if([currentPassword isEqualToString:@""]) return FALSE;
	return TRUE;
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	[theTextField resignFirstResponder];
	return TRUE;
}




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
