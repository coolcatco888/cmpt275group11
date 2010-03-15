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
//   - 1.0 - Implemented
//
//  Copyright 2010 Team Awesome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "QuestionParser.h"
#import "QuestionViewManager.h"

@interface QuizMonkeyViewController : UIViewController {
	IBOutlet UIView *mainMenuView;
	IBOutlet UIView *questionView;
	IBOutlet UIView *highScoresView;
	IBOutlet UIView *finalScoreView;

	//Main Menu View Outlets
	
	//Question View Outlets (Passed on to QuestionViewManager)
	IBOutlet UIButton *questionQuitButton;
	IBOutlet UIButton *questionNextButton;
	IBOutlet UILabel *questionSentenceLabel;
	IBOutlet UILabel *questionSentenceBottomLabel;
	IBOutlet UILabel *questionTypeLabel;
	IBOutlet UIImageView *questionImage;
	IBOutlet UIImageView *smallMonkeyImage;
	IBOutlet UIProgressView *timerProgress;
	IBOutlet UIButton *questionChoice1Button;
	IBOutlet UIButton *questionChoice2Button;
	IBOutlet UIButton *questionChoice3Button;
	IBOutlet UIButton *questionChoice4Button;
	NSArray *questionChoiceButtons;
	QuestionViewManager *manager;
	
	//High Scores View Outlets
	CGPoint TapLocation;
	
	//Final Score View Outlet
	IBOutlet UILabel *finalScoreLabel;
}

//Main Menu View Functions
-(IBAction)loadQuestionView:(id)sender;
-(IBAction)loadHighScoresView:(id)sender;
-(IBAction)exitApplication:(id)sender;

//Question View Functions
-(IBAction)exitQuestionView:(id)sender;
-(IBAction)selectChoice:(id)sender;
-(IBAction)nextQuestion:(id)sender;

//High Scores View Funtions
-(IBAction)exitHighScoresView:(id)sender;

//Final Score View Functions
-(IBAction)exitFinalScoreView:(id)sender;

//Main Menu Test Functions


//Final Score Functions

@end

