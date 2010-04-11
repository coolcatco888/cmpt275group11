//
//  OnlineViewController.h
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 3/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Score.h"
#import "ScoreParser.h"

#define HIGHSCORES_SCORE_H 29

@interface OnlineViewController : UIViewController {
	IBOutlet UIView *mainMenuView;
	IBOutlet UIView *submitView;
	IBOutlet UIView *highScoresView;
	IBOutlet UIView *highScoresSubView;
	

	IBOutlet UIButton *submitButton;
	IBOutlet UIButton *continueButton;
	IBOutlet UITextField *studentID_tf;
	IBOutlet UITextField *password_tf;
	
	NSMutableString *submitScoreURL;
	NSMutableString *highScoresURL;
	
	NSString *currentStudentID;
	NSString *currentPassword;

	Score *currentScore;
	
	UIButton *newButton;
	IBOutlet UILabel *statusLabel;
	
	bool submitingScore;
	bool gettingScores;
	
	
	ScoreParser *scoreParser;
	NSData *highScoresData;
	NSArray *highScoresArray;
	
	NSData *submitScoreData;
	
	/*
	
	Score *submissionScore;
	
	NSString *url;
	NSArray *serverVariables;
	Score *score;
	NSMutableString *submitionString;*/
}
@property (assign) NSMutableString *submitScoreURL;
@property (assign) NSMutableString *highScoresURL;
@property (assign) Score *currentScore;

////////////
- (void)loadHighScoresFromURL;
- (void)submitCurrentScore;
- (IBAction)submitScore;
- (IBAction)exitSubmitView;
- (IBAction)exitHighScoresView;
- (void)newButtonInHighScoresSubView:(NSString*)title buttonX:(CGFloat)buttonX buttonY:(CGFloat)buttonY alignment:(UIControlContentHorizontalAlignment)alignment;
- (void)appendVariableToSubmitionString:(NSString*)variable value:(NSString*)value;
- (BOOL)validUsernameAndPassword;
//- (void)retrievePersonalHighScores;
//- (void)retrieveGlobalHighScores;
@end
