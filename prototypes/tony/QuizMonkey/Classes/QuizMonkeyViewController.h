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
	IBOutlet UIView* main;
	
	PickOutWordsQuestion* q1;
	
	
	
}

-(IBAction)PushButton:(id)sender;
-(void)renew;

@end

