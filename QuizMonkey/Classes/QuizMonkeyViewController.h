//
//  QuizMonkeyViewController.h
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 2/15/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ObjectQuestionList;

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
	IBOutlet UILabel *lbl_Type;
	IBOutlet UILabel *lbl_pic_Name;
	IBOutlet UILabel *lbl_Sentence;
	IBOutlet UILabel *lbl_Choice1_Word;
	IBOutlet UILabel *lbl_Choice2_Word;
	IBOutlet UILabel *lbl_Choice3_Word;
	IBOutlet UILabel *lbl_Choice4_Word;
	IBOutlet UILabel *lbl_Choice1_Points;
	IBOutlet UILabel *lbl_Choice2_Points;
	IBOutlet UILabel *lbl_Choice3_Points;
	IBOutlet UILabel *lbl_Choice4_Points;
	IBOutlet UILabel *lbl_Time;

}

-(IBAction)ShowQuestionView:(id)sender;
-(IBAction)ExitQuestionView:(id)sender;
-(IBAction)ShowHighScoresView:(id)sender;
-(IBAction)ExitHighScoresView:(id)sender;
-(void) createButton:(NSString*) title :(int) x :(int) y :(int) width :(int) height :(SEL) buttonActionFunction;
-(void)selectChoice:(id)sender;

-(IBAction)SetCell:(id)sender;
-(IBAction)LoadObjectQuestion:(id)sender;

-(IBAction)ShowAlert:(id)sender;
//-(IBAction)NewButton:(id)sender;
//-(IBAction)Change_Button:(id)sender;
//-(IBAction)Change_Picture:(id)sender;
//-(IBAction)LoadArray:(id)sender;
//-(IBAction)SetQuestion:(id)sender;

@end

