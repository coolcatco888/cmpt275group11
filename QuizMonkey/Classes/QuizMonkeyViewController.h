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
	IBOutlet UIView *vew_MainMenu;
	IBOutlet UIView *vew_Question;
	IBOutlet UIView *vew_HighScores;
	IBOutlet UIButton *btn_Play;
	IBOutlet UIButton *btn_Quit;
	IBOutlet UIButton *btn_New;
	IBOutlet UIImageView *img_Monkey;
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

-(IBAction)SetCell:(id)sender;
-(IBAction)LoadObjectQuestion:(id)sender;

-(IBAction)ShowAlert:(id)sender;
//-(IBAction)NewButton:(id)sender;
//-(IBAction)Change_Button:(id)sender;
//-(IBAction)Change_Picture:(id)sender;
//-(IBAction)LoadArray:(id)sender;
//-(IBAction)SetQuestion:(id)sender;

@end

