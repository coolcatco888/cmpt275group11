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
	NSMutableArray *QuestionList;
	IBOutlet UIView *mainMenuView;
	IBOutlet UIView *questionView;
	IBOutlet UIView *highScoresView;
	IBOutlet UIButton *playButton;
	IBOutlet UIButton *quitButton;
	IBOutlet UIButton *newButton;
	IBOutlet UIImageView *monkeyImage;
	IBOutlet UILabel *lbl_Question;
	IBOutlet UILabel *lbl_New;
	UIAlertView *alr_Alert;
	NSArray *ThisArray;
	IBOutlet UIScrollView *scr_HighScores;
	IBOutlet UITableViewCell *cel_Score1;
	IBOutlet UITableView *tbl_HighScores;
	CGPoint TapLocation;
	IBOutlet UILabel *lbl_Y;
	NSXMLParser *QuestionParser;
	

	//Question Window
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
	
	IBOutlet UIImageView *question;

}

-(IBAction)ShowQuestionView:(id)sender;
-(IBAction)ExitQuestionView:(id)sender;
-(IBAction)ShowHighScoresView:(id)sender;
-(IBAction)ExitHighScoresView:(id)sender;
-(void)selectChoice:(id)sender;

-(IBAction)SetCell:(id)sender;
-(IBAction)LoadObjectQuestion:(id)sender;

-(IBAction)ShowAlert:(id)sender;

@end

