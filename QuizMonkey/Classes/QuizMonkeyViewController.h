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
	NSMutableSet* selectedChoices;

}

-(IBAction)ShowQuestionView:(id)sender;
-(IBAction)ExitQuestionView:(id)sender;
-(IBAction)ShowHighScoresView:(id)sender;
-(IBAction)ExitHighScoresView:(id)sender;
-(void)selectChoice:(id)sender;
- (NSMutableArray*) select10Questions: (NSMutableArray*) questionList;
-(IBAction)SetCell:(id)sender;
-(void) loadQuestionFromIndex: (NSUInteger) index;
-(IBAction)ShowAlert:(id)sender;

@end

