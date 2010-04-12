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

@synthesize questionViewController;
@synthesize onlineViewController;

//##############################################################
//Main View Functions
//##############################################################
-(IBAction)loadQuestionView:(id)sender {
	//Loading a question view controller object and displaying the question view
	questionViewController = [questionViewController init];
	[mainMenuView addSubview:questionView];
}
-(IBAction)loadHighScoresView:(id)sender {
	//Loading an online view controller object and displaying the high scores view
	onlineViewController = [onlineViewController init];
	[onlineViewController loadHighScoresFromURL];
}
-(IBAction)exitApplication:(id)sender {
	//Exits the appliction
	exit(0);
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

////////////////////////Final Score View Functions
-(IBAction) exitFinalScoreView:(id)sender {
	//Hides the final view
	[finalScoreView removeFromSuperview];
	onlineViewController = [onlineViewController init];
	[onlineViewController setCurrentScore:[questionViewController finalScore]];
	[onlineViewController submitCurrentScore];
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
	//Custom class objects
	[questionViewController release];
	[onlineViewController release];
	
	//View Outlets
	[mainMenuView release];
	[questionView release];
	[highScoresView release];
	[finalScoreView release];

	//Final Score View Outlets
	[finalScoreLabel release];
	
	[super dealloc];
}

@end
