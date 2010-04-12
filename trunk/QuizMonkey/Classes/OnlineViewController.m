//
//  OnlineViewController.m
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 3/31/10.
//
//  Worked on by Cley, Ariel, Tony, Meiko, Daniel
//
//  Known Bugs: See the header file
//
//  Changes: See the header file
//
//  Copyright 2010 Team Awesome. All rights reserved.
//

#import "OnlineViewController.h"


@implementation OnlineViewController

@synthesize submitScoreURL;
@synthesize highScoresURL;
@synthesize currentScore;

- init {
	//Seting up Objects for later use
	scoreParser = [ScoreParser new];
	currentStudentID = @"";
	currentPassword = @"";
	submitScoreURL = [NSMutableString stringWithCapacity:255];
	highScoresURL = [NSMutableString stringWithCapacity:255];
	[submitScoreURL setString:@"http://quizmonkey.x10hosting.com/submit.php?"];
	[highScoresURL setString:@"http://quizmonkey.x10hosting.com/viewxml.php?"];
	[highScoresURL retain];
	[submitScoreURL retain];
	[submitButton setAlpha:1.0f];
	[submitButton setEnabled:TRUE];
	[statusLabel setText:@""];
	[statusLabel setHidden:TRUE];
	submitingScore = FALSE;
	gettingScores = FALSE;
	return self;
}
- (void)loadHighScoresFromURL {
	//The first time this function runs it sets gettingScores to true and modifies the submitView acordingly
	if (!gettingScores) {
		gettingScores = TRUE;
		[submitButton setTitle:@"Get Scores" forState:0];
		[mainMenuView addSubview:submitView];
	}
	else {
		[highScoresURL setString:@"http://quizmonkey.x10hosting.com/viewxml.php?"];
		[highScoresURL appendString:@"username="];
		[highScoresURL appendString:currentStudentID];
		[highScoresURL appendString:@"&password="];
		[highScoresURL appendString:currentPassword];
		NSLog(highScoresURL);
		//After we have a URL, we load the data using the URL
		highScoresData = [NSData dataWithContentsOfURL:[NSURL URLWithString:highScoresURL]];
		if([[[NSString alloc] initWithData:highScoresData encoding:NSUTF8StringEncoding] isEqualToString:@"FAILED"]) {
			[statusLabel setText:@"Invalid username or password"];
			[statusLabel setHidden:FALSE];
		}
		else {
			//Then display all the scores onto the high score view
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
			[submitView removeFromSuperview];
			[mainMenuView addSubview:highScoresView];
		}
	}
}
- (void)submitCurrentScore {
	//The first time this function runs it sets submitingScores to true and modifies the submitView acordingly
	if (!submitingScore){
		submitingScore = TRUE;
		[submitButton setTitle:@"Submit" forState:0];
		[mainMenuView addSubview:submitView];
	}
	else {
		//A URL is set up containing all the data in the current score object
		[submitScoreURL setString:@"http://quizmonkey.x10hosting.com/submit.php?"];
		[self appendVariableToSubmitionString:@"username" value:currentStudentID];
		[submitScoreURL appendString:@"&"];
		[self appendVariableToSubmitionString:@"password" value:currentPassword];
		[submitScoreURL appendString:@"&"];
		[self appendVariableToSubmitionString:@"timeleft" value:[[NSNumber numberWithInt:[currentScore timeLeft]] stringValue]];
		[submitScoreURL appendString:@"&"];
		[self appendVariableToSubmitionString:@"points" value:[[NSNumber numberWithInt:[currentScore points]] stringValue]];
		[submitScoreURL appendString:@"&"];
		[self appendVariableToSubmitionString:@"maxpoints" value:[[NSNumber numberWithInt:[currentScore maxPoints]]  stringValue]];
		bool OneOrMoreAchievementsAchieved = FALSE;
		[submitScoreURL appendString:@"&"];
		[submitScoreURL appendString:@"achievements="];

		if(![currentScore reward0] && ![currentScore reward1] && ![currentScore reward2] && ![currentScore reward3] && ![currentScore reward4] && ![currentScore reward0])
			[submitScoreURL appendString:@"none"];
		
		if([currentScore reward0]){
			if(OneOrMoreAchievementsAchieved)
				[submitScoreURL appendString:@"-"];
			OneOrMoreAchievementsAchieved = TRUE;
			[submitScoreURL appendString:@"0"];
		}
		if([currentScore reward1]){
			if(OneOrMoreAchievementsAchieved)
				[submitScoreURL appendString:@"-"];
			OneOrMoreAchievementsAchieved = TRUE;
			[submitScoreURL appendString:@"1"];
		}
		if([currentScore reward2]){
			if(OneOrMoreAchievementsAchieved)
				[submitScoreURL appendString:@"-"];
			OneOrMoreAchievementsAchieved = TRUE;
			[submitScoreURL appendString:@"2"];
		}
		if([currentScore reward3]){
			if(OneOrMoreAchievementsAchieved)
				[submitScoreURL appendString:@"-"];
			OneOrMoreAchievementsAchieved = TRUE;
			[submitScoreURL appendString:@"3"];
		}
		if([currentScore reward4]){
			if(OneOrMoreAchievementsAchieved)
				[submitScoreURL appendString:@"-"];
			OneOrMoreAchievementsAchieved = TRUE;
			[submitScoreURL appendString:@"4"];
		}
		if([currentScore reward5]){
			if(OneOrMoreAchievementsAchieved)
				[submitScoreURL appendString:@"-"];
			OneOrMoreAchievementsAchieved = TRUE;
			[submitScoreURL appendString:@"5"];
		}
		NSLog(submitScoreURL);
		//Then Data is loaded from the server and at the same time the score data is sent
		submitScoreData = [NSData dataWithContentsOfURL:[NSURL URLWithString:submitScoreURL]];
		if([[[NSString alloc] initWithData:submitScoreData encoding:NSUTF8StringEncoding] isEqualToString:@"FAILED"]) {
			[statusLabel setText:@"Invalid username or password"];
			[statusLabel setHidden:FALSE];
		} else {
			[statusLabel setText:@"Score submitted successfully"];
			[statusLabel setHidden:FALSE];
			[submitButton setEnabled:FALSE];
			[submitButton setAlpha:0.5f];
		}
	}
}
- (IBAction)submitScore {
	//The submit score button
	[studentID_tf resignFirstResponder];
	[password_tf resignFirstResponder];

	currentStudentID = [studentID_tf text];
	currentPassword = [password_tf text];
	
	if([self validUsernameAndPassword]){
		if(submitingScore) {
			[statusLabel setHidden:TRUE];
			[self submitCurrentScore];
		}
		if(gettingScores) {
			[statusLabel setHidden:TRUE];
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
