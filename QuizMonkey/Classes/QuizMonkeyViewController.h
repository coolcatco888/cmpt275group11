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
	NSMutableArray *questionList;
	IBOutlet UIView *mainMenuView;
	IBOutlet UIView *questionView;
	IBOutlet UIView *highScoresView;
	IBOutlet UIButton *playButton;
	IBOutlet UIButton *quitButton;
	IBOutlet UIButton *newButton;
	IBOutlet UIImageView *monkeyImage;
	UIAlertView *alr_Alert;
	UIAlertView *alert;
	IBOutlet UIScrollView *scr_HighScores;
	IBOutlet UITableViewCell *cel_Score1;
	IBOutlet UITableView *tbl_HighScores;
	CGPoint TapLocation;
	IBOutlet UILabel *lbl_Y;//Will not run if this is removed but it will compile for some reason
	NSXMLParser *QuestionParser;
	

	//Question Window
	NSUInteger currentQuestionIndex;
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
	NSMutableArray* selectedChoices;
	NSUInteger maxNumberOfChoiceSelections;
	NSUInteger totalPoints;
	
	QuestionViewManager* manager;

}

-(IBAction)ShowQuestionView:(id)sender;
-(IBAction)exitQuestionView:(id)sender;
-(IBAction)ShowHighScoresView:(id)sender;
-(IBAction)ExitHighScoresView:(id)sender;

-(IBAction)SetCell:(id)sender;
-(IBAction)ShowAlert:(id)sender;

-(IBAction)selectChoice:(id)sender;
-(NSMutableArray*) select10Questions: (NSMutableArray*) questionList;
-(NSUInteger) getMaxNumberOfChoiceSelections: (NSArray*) points;
-(IBAction)nextQuestion:(id)sender;
-(void) loadQuestionFromIndex: (NSUInteger) index;
-(int) calculateTotalScore: (NSArray*) points;

@end

