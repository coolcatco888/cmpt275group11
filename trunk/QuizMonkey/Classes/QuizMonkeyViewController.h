//
//  QuizMonkeyViewController.h
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 2/15/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "QuestionParser.h"
#import "QuestionViewManager.h"

@interface QuizMonkeyViewController : UIViewController {
	IBOutlet UIView *mainMenuView;
	IBOutlet UIView *questionView;
	IBOutlet UIView *highScoresView;
	IBOutlet UIButton *playButton;
	IBOutlet UIButton *quitButton;
	IBOutlet UIButton *newButton;
	IBOutlet UIImageView *monkeyImage;
	IBOutlet UIImageView *smallMonkeyImage;
	IBOutlet UIProgressView* timerProgress;
	IBOutlet UIScrollView *scr_HighScores;
	IBOutlet UITableViewCell *cel_Score1;
	IBOutlet UITableView *tbl_HighScores;
	CGPoint TapLocation;
	IBOutlet UILabel *lbl_Y;//Will not run if this is removed but it will compile for some reason
	NSXMLParser *QuestionParser;
	
	//Question Window Attributes (Passed on to QuestionViewManager)
	IBOutlet UIButton *questionQuitButton;
	IBOutlet UIButton *questionNextButton;
	IBOutlet UIButton *questionChoice1Button;
	IBOutlet UIButton *questionChoice2Button;
	IBOutlet UIButton *questionChoice3Button;
	IBOutlet UIButton *questionChoice4Button;
	NSArray * questionChoiceButtons;
	IBOutlet UILabel *questionSentenceLabel;
	IBOutlet UILabel *questionSentenceBottomLabel;
	IBOutlet UILabel *questionTypeLabel;
	IBOutlet UIImageView *questionImage;
	
	QuestionViewManager* manager;
	
	//Final Score screen
	IBOutlet UIView *finalScoreView;
	IBOutlet UILabel *finalScoreLabel;
}

//Main Menu Functions
-(IBAction)ShowQuestionView:(id)sender;
-(IBAction)ShowHighScoresView:(id)sender;
-(IBAction)ExitHighScoresView:(id)sender;

//Main Menu Test Functions
-(IBAction)SetCell:(id)sender;
-(IBAction)ShowAlert:(id)sender;

//Question View Functions
-(IBAction)exitQuestionView:(id)sender;
-(IBAction)selectChoice:(id)sender;
-(IBAction)nextQuestion:(id)sender;

//Final Score Functions
-(IBAction) exitFinalScoreScreen:(id)sender;

@end

