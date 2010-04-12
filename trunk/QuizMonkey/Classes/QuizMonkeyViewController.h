//
//  QuizMonkeyViewController.h
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 2/15/10.
//
//  Worked on by Cley, Ariel, Tony, Meiko, Daniel
//
//  Known Bugs: none
//
//  Changes:
//   - 1.0 - Main menu designed
//	 - 1.1 - Question view designed and main menu added functionality
//	 - 1.2 - High Scores view designed and implemented scrolling on high scores
//	 - 1.3 - Queston view added functionality after Question View Manager was finished
//	 - 1.4 - Implemented final score view
//
//  Copyright 2010 Team Awesome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "QuestionParser.h"
#import "Score.h"
#import "ScoreParser.h"
#import "QuestionViewController.h"
#import "OnlineViewController.h"

@class QuestionViewController;
@class OnlineViewController;

@interface QuizMonkeyViewController : UIViewController {
	//Custom class objects
	QuestionViewController *questionViewController;
	OnlineViewController *onlineViewController;
	
	//View Outlets
	IBOutlet UIView *mainMenuView;//A reference to the main menu view
	IBOutlet UIView *questionView;//A reference to the question view
	IBOutlet UIView *highScoresView;//A reference to the high scores view
	IBOutlet UIView *finalScoreView;//A reference to the final score view
	IBOutlet UIView *submitView;//A reference to the submit score view

	//High Scores View Outlets
	CGPoint TapLocation;//Contains the coordinates of the last place that the user tapped (used for the highscores scrolling up and down)
	
	//Final Score View Outlet
	IBOutlet UILabel *finalScoreLabel;//A reference to the a label in the final score view used for displaying the final score of a quiz
}

@property (nonatomic, retain) IBOutlet QuestionViewController *questionViewController;
@property (nonatomic, retain) IBOutlet OnlineViewController *onlineViewController;

//Main Menu View Functions
-(IBAction)loadQuestionView:(id)sender;//Loads the question view
-(IBAction)loadHighScoresView:(id)sender;//Loads the high scores view
-(IBAction)exitApplication:(id)sender;//A function that exits the application

//Final Score View Functions
-(IBAction)exitFinalScoreView:(id)sender;//Hides the final score view

@end