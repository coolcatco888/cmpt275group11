//
//  QuizMonkeyViewController.h
//  QuizMonkey
//
//  Created by yang qiong on 2/13/10.
//  Copyright sfu 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "FillinBlankQuestion.h"
#import "PickOutWordsQuestion.h"


@interface QuizMonkeyViewController : UIViewController {

	IBOutlet UILabel* question_label;
	IBOutlet UILabel* result;
	IBOutlet UIView* main;
	
	IBOutlet UIButton* ans1;
	IBOutlet UIButton* ans2;
	IBOutlet UIButton* ans3;
	IBOutlet UIButton* ans4;
	NSMutableArray* question_array;
	int num;
	int total;
	Question* current_question;
	//Question* q1;
	
	
	
}

-(IBAction)PushButton:(id)sender;
-(void)renew;

@end

