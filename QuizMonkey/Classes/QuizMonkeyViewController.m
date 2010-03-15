//
//  QuizMonkeyViewController.m
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 2/15/10.
//
//  Worked on by Cley, Ariel, Tony, Meiko, Daniel
//
//  Known Bugs: See the header file
//
//  Changes: See the header file
//
//  Copyright 2010 Team Awesome. All rights reserved.
//



#import "QuizMonkeyViewController.h"

@implementation QuizMonkeyViewController


////////////////////////Main View Functions
-(IBAction)loadQuestionView:(id)sender {
	questionChoiceButtons = [NSArray arrayWithObjects: questionChoice1Button, questionChoice2Button, questionChoice3Button, questionChoice4Button, nil]; 
	manager = [[QuestionViewManager alloc] initQuestionViewManager:mainMenuView 
																  :questionView 
																  :finalScoreView 
																  :questionSentenceLabel 
																  :questionSentenceBottomLabel 
																  :questionTypeLabel 
																  :finalScoreLabel 
																  :questionImage 
																  :smallMonkeyImage
																  :timerProgress
																  :questionChoiceButtons];
	
}
-(IBAction)loadHighScoresView:(id)sender {
	[mainMenuView addSubview:highScoresView];
}
-(IBAction)exitApplication:(id)sender {
	exit(0);
}


////////////////////////Question View Functions
-(IBAction)exitQuestionView:(id)sender {
	//Removing subview
	[manager quitGame];
	[manager stopTimer];
}

-(IBAction) selectChoice:(id)sender {
	[manager selectChoice:sender];
}

-(IBAction)nextQuestion:(id)sender {
	[manager nextQuestion:sender];	
}


////////////////////////High Scores View Functions
-(IBAction)exitHighScoresView:(id)sender {
	[highScoresView removeFromSuperview];
}

-(void)touchesBegan: (NSSet *)touches withEvent:(UIEvent *)event {
	TapLocation = [[[event allTouches] anyObject] locationInView:mainMenuView];
}
-(void)touchesMoved: (NSSet *)touches withEvent:(UIEvent *)event {
	CGPoint TapLocationNew = [[[event allTouches] anyObject] locationInView:mainMenuView];
	
	//Applying the displacement to the center of the screen, moving it up and down
	highScoresView.center = CGPointMake(highScoresView.center.x , highScoresView.center.y - (TapLocation.y - TapLocationNew.y));
	
	//Seting the boundaries so the high scores can't go off the screen
	if(highScoresView.center.y > 300)
		highScoresView.center = CGPointMake(highScoresView.center.x , 300);
	if(highScoresView.center.y < 0)
		highScoresView.center = CGPointMake(highScoresView.center.x , 0);
	
	//Updating the user's tap location
	TapLocation = TapLocationNew;
	
	//NSLog(@"Y: %f", TapLocationNew.y);

}
-(void)touchesEnded: (NSSet *)touches withEvent:(UIEvent *)event {
//	TapLocation = [[[event allTouches] anyObject] locationInView:mainMenuView];
//	newButton.center = [[[event allTouches] anyObject] locationInView:mainMenuView];
}

////////////////////////Final Score View Functions
-(IBAction) exitFinalScoreView:(id)sender {
	[finalScoreView removeFromSuperview];
	
	//TODO: Add online score submission!
}




// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
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
	[mainMenuView release];
	[questionView release];
	[highScoresView release];
	[finalScoreView release];
	
	//Main Menu View Outlets
	
	//Question View Outlets (Passed on to QuestionViewManager)
	[questionQuitButton release];
	[questionNextButton release];
	[questionSentenceLabel release];
	[questionSentenceBottomLabel release];
	[questionTypeLabel release];
	[questionImage release];
	[smallMonkeyImage release];
	[timerProgress release];
	[questionChoice1Button release];
	[questionChoice2Button release];
	[questionChoice3Button release];
	[questionChoice4Button release];
	[questionChoiceButtons release];
	[manager release];
	
	//High Scores View Outlets
	
	//Final Score screen
	[finalScoreLabel release];

	[super dealloc];
}

@end
