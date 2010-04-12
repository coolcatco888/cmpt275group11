//
//  OnlineViewController.h
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 3/31/10.
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
#import "Score.h"
#import "ScoreParser.h"

#define HIGHSCORES_SCORE_H 29

@interface OnlineViewController : UIViewController {
	IBOutlet UIView *mainMenuView;//A reference to the main menu view
	IBOutlet UIView *submitView;//A reference to the submit view
	IBOutlet UIView *highScoresView;//A reference to the high scores view
	IBOutlet UIView *highScoresSubView;//A reference to the high scores sub view
	
	IBOutlet UIButton *submitButton;//The button used for submitting the username and password to the server
	IBOutlet UIButton *continueButton;//The button used for exiting the submission view
	IBOutlet UITextField *studentID_tf;//StudentID textfield
	IBOutlet UITextField *password_tf;//Password textfield
	
	NSMutableString *submitScoreURL;//The string used for submitting a score
	NSMutableString *highScoresURL;//The string used for retrieving high scores
	
	NSString *currentStudentID;//A string that will contain the current StudentID
	NSString *currentPassword;//A string that will conatin the current password

	Score *currentScore;//The current score being submited or the current score being loaded onto the high scores view
	
	UIButton *newButton;//Used to display the highscore fields
	IBOutlet UILabel *statusLabel;//Used to display the statis of the submission after clicking the ubmit button
	
	bool submitingScore;//A boolean used to know if the Onlone View Controller is submitting a score
	bool gettingScores;//A boolean used to know if the Onlone View Controller is loading high scores

	ScoreParser *scoreParser;//The score parser used for parsing high scores
	NSData *highScoresData;//The data loaded from the highscoreURL
	NSArray *highScoresArray;//The array of score object to be displayed
	
	NSData *submitScoreData;//The data loaded from the submissionURL
}
@property (assign) NSMutableString *submitScoreURL;
@property (assign) NSMutableString *highScoresURL;
@property (assign) Score *currentScore;

////////////
- (void)loadHighScoresFromURL;//Loading high scores from URL
- (void)submitCurrentScore;//Submit the current cure to the server
- (IBAction)submitScore;//The submit score button calls either loadHighScoresFromURL or submitCurrentScore accordingly
- (IBAction)exitSubmitView;//exits the Submit view
- (IBAction)exitHighScoresView;//exits the high score view
- (void)newButtonInHighScoresSubView:(NSString*)title//Code for creating a new button with the title
							 buttonX:(CGFloat)buttonX//X Coordinate of the button
							 buttonY:(CGFloat)buttonY//Y Coordinate of the button
						   alignment:(UIControlContentHorizontalAlignment)alignment;//And the text Alignment of the button
- (void)appendVariableToSubmitionString:(NSString*)variable//Used when building the submit score URL variable is used for showing what the value means, like "username"
								  value:(NSString*)value;//The actual value after "username="
- (BOOL)validUsernameAndPassword;//Check if the username and password is valid
@end
