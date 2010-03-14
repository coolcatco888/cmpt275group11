//
//  QuestionViewManager.h
//  QuizMonkey
//
//  This class is responsible for displaying the questions on the screen along with managing the game logic
//
//  Created by Cley Tang on 3/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Question.h"
#import "QuestionParser.h"

@interface QuestionViewManager : NSObject {
	//Created from constructor
	IBOutlet UIView *mainMenuScreen;//Holds a reference to the main menu
	IBOutlet UIView *questionScreen;//Will be set as a subview for the main menu
	UIView* finalScoreScreen;
	IBOutlet UILabel *questionSentenceLabel;//Reference to the sentence label
	IBOutlet UILabel *questionSentenceBottomLabel;//Reference to the sentence label below the question image
	IBOutlet UILabel *questionTypeLabel;//Displays the type of question
	UILabel *finalScoreLabel;
	IBOutlet UIImageView *questionImage;//Displays the image of the question, if any
	IBOutlet UIImageView *monkeyImage;//Displays the image of the monkey after each question
	IBOutlet UIProgressView *timerProgress;//Displays the time left in bar form
	NSArray* questionChoiceButtons;//Holds all of the choice buttons
	
	
	NSMutableArray* questionList;//Holds the list of questions
	NSUInteger currentQuestionIndex;//Holds the index of the current queestion
	Question* currentQuestion;//Holds current question object
	NSMutableSet* selectedChoices;//Holds Selected choices
	NSUInteger maxNumberOfChoiceSelections;//Holds the max number of allowable choice selections
	NSUInteger totalPointsForCurrentQuestion;//Holds the total points for current question
	NSUInteger totalPoints;//Stores the total points in the quiz
	NSUInteger totalTime;//Stores the total time of the quiz
	NSUInteger totalPointsAcquired;//Stores the total points acquired by the student
	NSUInteger currentTimeLeft;
	NSTimer* timer;
	UIAlertView *alert;//Holds alert box for displaying score

}

@property (assign) IBOutlet UIView* mainMenuScreen;
@property (assign) IBOutlet UIView* questionScreen;
@property (assign) IBOutlet UIView* finalScoreScreen;
@property (assign) IBOutlet UILabel *questionSentenceLabel;
@property (assign) IBOutlet UILabel *questionSentenceBottomLabel;
@property (assign) IBOutlet UILabel *questionTypeLabel;
@property (assign) IBOutlet UILabel *finalScoreLabel;
@property (assign) IBOutlet UIImageView *questionImage;
@property (assign) IBOutlet UIProgressView *timerProgress;
@property (assign) NSArray* questionChoiceButtons;

@property (assign) NSMutableArray* questionList;
@property (assign) NSUInteger currentQuestionIndex;
@property (assign) Question* currentQuestion;
@property (assign) NSMutableSet* selectedChoices;
@property (assign) NSUInteger maxNumberOfChoiceSelections;

-(QuestionViewManager*) initQuestionViewManager:(UIView*) mainView 
											   :(UIView*) questionView 
											   :(UIView*) finalScoreView 
											   :(UILabel*) sentenceLabel 
											   :(UILabel*) sentenceLabelBottom 
											   :(UILabel*) questionType
											   :(UILabel*) finalScore
											   :(UIImageView*) image 
											   :(UIImageView*) monkey
											   :(UIProgressView*) progress
											   :(NSArray*) questionButtons;

-(IBAction)selectChoice:(id)sender;//Called when a choice has been selected, handles selecting/deselecting the choice
-(NSMutableArray*) select10Questions: (NSMutableArray*) questionList;//After parsing the document, we will only select 10 random questions
-(NSUInteger) getMaxNumberOfChoiceSelections: (NSArray*) points;//This function determines the number of choices the student can select for a given questions
-(IBAction)nextQuestion:(id)sender;//validates the question when user presses 'Next'
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;//Called whenever a button is pressed on an alert window, handles loading next question and quitting the game
-(void) loadQuestionFromIndex: (NSUInteger) index;//Loads a question from a given index
-(int) calculateTotalScore: (NSArray*) points;//Calculates the total score for this entire quiz
-(void) resetAllButtons;//Resets buttons back to normal non-higlighted state
-(void) updateTimer;//fired every 1 second, checks whether time is up
-(void) quitGame;//Removes questionScreen from the mainview
-(void) stopTimer;//Stop timer from view controller
@end
