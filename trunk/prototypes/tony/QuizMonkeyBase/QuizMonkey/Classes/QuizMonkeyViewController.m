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
	//Set up the array of the four buttons in the question view
	questionChoiceButtons = [NSArray arrayWithObjects: questionChoice1Button, questionChoice2Button, questionChoice3Button, questionChoice4Button, nil]; 
	
	//Initiates the question manager and in the initiation it passes all the references of all the question view objects
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
	//Shows the high scores view
	[mainMenuView addSubview:highScoresView];
}
-(IBAction)exitApplication:(id)sender {
	//Exits the appliction
	exit(0);
}


////////////////////////Question View Functions
-(IBAction) selectChoice:(id)sender {
	//Passes the id of the button which called this function to the selectChoice function in the question manager
	//So that the manager knows which button was pressed
	[manager selectChoice:sender];
}

-(IBAction)nextQuestion:(id)sender {
	//Calls the next question function to display the next question
	[manager nextQuestion:sender];	
}
-(IBAction)exitQuestionView:(id)sender {
	//Removing subview
	[manager quitGame];
	[manager stopTimer];
}


////////////////////////High Scores View Functions
-(void)touchesBegan: (NSSet *)touches withEvent:(UIEvent *)event {
	//This function is called when the user taps a location on the screen
	//The function then stores the location in the Taplocation object for later use
	TapLocation = [[[event allTouches] anyObject] locationInView:mainMenuView];
}
-(void)touchesMoved: (NSSet *)touches withEvent:(UIEvent *)event {
	//This function is called when the user moves a finger along the screen
	//A new tap location object is created to store the new location that the user moved the finger to
	CGPoint TapLocationNew = [[[event allTouches] anyObject] locationInView:mainMenuView];
	
	//Applying the Y coordinate displacement to the center of high scores view, moving it up and down
	highScoresView.center = CGPointMake(highScoresView.center.x , highScoresView.center.y - (TapLocation.y - TapLocationNew.y));
	
	//Seting the boundaries so the high scores can't go off the screen
	if(highScoresView.center.y > 300)
		highScoresView.center = CGPointMake(highScoresView.center.x , 300);
	if(highScoresView.center.y < 0)
		highScoresView.center = CGPointMake(highScoresView.center.x , 0);
	
	//Updating the user's tap location
	TapLocation = TapLocationNew;
}
-(IBAction)exitHighScoresView:(id)sender {
	//Hides the high scores view
	[highScoresView removeFromSuperview];
}

////////////////////////Final Score View Functions
-(IBAction) exitFinalScoreView:(id)sender {
	//Hides the final view
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
	//View Outlets
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
	//(None)
	
	//Final Score View Outlets
	[finalScoreLabel release];

	[super dealloc];
}

@end
