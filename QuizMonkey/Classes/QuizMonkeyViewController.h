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
//#import "SubmissionViewController.h"
#import "OnlineViewController.h"

@class QuestionViewController;
//@class SubmissionViewController;
@class OnlineViewController;

@interface QuizMonkeyViewController : UIViewController {
	QuestionViewController *questionViewController;
	OnlineViewController *onlineViewController;
	//SubmissionViewController *submissionViewController;
//	WebInterface *webInterface;
	//View Outlets
//	Score *score;
	
	IBOutlet UIView *mainMenuView;//A reference to the main menu view
	IBOutlet UIView *questionView;//A reference to the question view
	IBOutlet UIView *highScoresView;//A reference to the high scores view
	IBOutlet UIView *finalScoreView;//A reference to the final score view
	IBOutlet UIView *submitView;//A reference to the submit score view
	
	IBOutlet UILabel *labelTemplate;
	
	//Main Menu View Outlets
	
	//Question View Outlets (Passed on to QuestionViewManager)
	/*	IBOutlet UIButton *questionQuitButton;//A reference to the quit button in the question view
	 IBOutlet UIButton *questionNextButton;//A reference to the next button in the question view
	 IBOutlet UILabel *questionSentenceLabel;//Used for displaying the actual setence for the question being asked
	 IBOutlet UILabel *questionSentenceBottomLabel;//Used for displaying the setence for the question when the question includes an image
	 IBOutlet UILabel *questionTypeLabel;//Used for displaying the type of question being asked
	 IBOutlet UIImageView *questionImage;//Used for displaying an image if the question includes one
	 IBOutlet UIImageView *smallMonkeyImage;//Used for displaying the profesor Monkey image at the bottom right of the question view, when a question is answered
	 IBOutlet UIProgressView *timerProgress;//Used for displaying the timer progress bar throughout the questions
	 IBOutlet UIButton *questionChoice1Button;//A reference to the leftmost choice button in the question view
	 IBOutlet UIButton *questionChoice2Button;//A reference to the center-left choice button in the question view
	 IBOutlet UIButton *questionChoice3Button;//A reference to the center-right choice button in the question view
	 IBOutlet UIButton *questionChoice4Button;//A reference to the rightmost choice button in the question view
	 */	NSArray *questionChoiceButtons;//An array that holds the previous four button references for easy access
	//	QuestionViewManager *manager;//A question manager object used for controll of the question view
	
	//High Scores View Outlets
	CGPoint TapLocation;//Contains the coordinates of the last place that the user tapped (used for the highscores scrolling up and down)
	
	//Final Score View Outlet
	IBOutlet UILabel *finalScoreLabel;//A reference to the a label in the final score view used for displaying the final score of a quiz
}

@property (nonatomic, retain) IBOutlet QuestionViewController *questionViewController;
//@property (nonatomic, retain) IBOutlet SubmissionViewController *submissionViewController;
@property (nonatomic, retain) IBOutlet OnlineViewController *onlineViewController;
//@property (assign) IBOutlet UIView *submitView;

//Main Menu View Functions
-(IBAction)loadQuestionView:(id)sender;//Loads the question view
-(IBAction)loadHighScoresView:(id)sender;//Loads the high scores view
-(IBAction)exitApplication:(id)sender;//A function that exits the application

//Question View Functions
//-(IBAction)exitQuestionView:(id)sender;//Hides the question view
//-(IBAction)selectChoice:(id)sender;//Used when the user taps a choice in the question view
//-(IBAction)nextQuestion:(id)sender;//Used when the user taps the next button in the question view

//High Scores View Funtions
-(IBAction)exitHighScoresView:(id)sender;//Hides the high scores view

//Final Score View Functions
-(IBAction)exitFinalScoreView:(id)sender;//Hides the final score view

@end

