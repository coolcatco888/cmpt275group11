//
//  QuestionViewManager.h
//  QuizMonkey
//
//  This class is responsible for displaying the questions on the screen along with managing the game logic
//
//  Created by Cley Tang on 3/12/10.
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
#import <Foundation/Foundation.h>
#import "Question.h"
#import "QuestionParser.h"

//word buttons' setting
#define WORD_BUTTON_FONT_SIZE 20
#define WORD_BUTTON_UNIT_HEIGHT 30
#define WORD_BUTTON_UNIT_WEIGHT  ((12*WORD_BUTTON_FONT_SIZE)/16)


@interface QuestionViewManager : NSObject {
	//Created from constructor
	IBOutlet UIView *mainMenuScreen;//Holds a reference to the main menu
	IBOutlet UIView *questionScreen;//Will be set as a subview for the main menu
	IBOutlet UIView* finalScoreScreen;//This holds a reference to the screen that displays the student's final score at the end of the game
	IBOutlet UILabel *questionSentenceLabel;//Reference to the sentence label
	IBOutlet UILabel *questionSentenceBottomLabel;//Reference to the sentence label below the question image
	IBOutlet UILabel *questionTypeLabel;//Displays the type of question
	IBOutlet UILabel *finalScoreLabel;
	IBOutlet UIImageView *questionImage;//Displays the image of the question, if any
	IBOutlet UIImageView *monkeyImage;//Displays the image of the monkey after each question
	IBOutlet UIProgressView *timerProgress;//Displays the time left in bar form
	NSArray* questionChoiceButtons;//Holds all of the choice buttons
	NSMutableArray* questionWords;//a list of word buttons (for find the verb/nouns/adj.)
	UIView* buttonWordsView; 

	
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
@property (assign) NSMutableArray* questionWords;
@property (assign) UIView* buttonWordsView; 

@property (assign) NSMutableArray* questionList;
@property (assign) NSUInteger currentQuestionIndex;
@property (assign) Question* currentQuestion;
@property (assign) NSMutableSet* selectedChoices;
@property (assign) NSUInteger maxNumberOfChoiceSelections;

//This initializes the question view manager with all of the appropriate screen objects
-(QuestionViewManager*) initQuestionViewManager:(UIView*) mainView//Reference to the Main Menu window 
											   :(UIView*) questionView//Reference to Question Window
											   :(UIView*) finalScoreView//Reference to the Final Score window
											   :(UILabel*) sentenceLabel//Reference to the Sentence Label in the Question Window
											   :(UILabel*) sentenceLabelBottom //Refernce to the Sentence Label below the Question image in the Question Window
											   :(UILabel*) questionType//Reference to the label that displays the question type in the question window
											   :(UILabel*) finalScore//Label that displays the student's final score in the final score window
											   :(UIImageView*) image //Refernce to the question image
											   :(UIImageView*) monkey//Reference to the professer monkey image that displays when an alert is displayed
											   :(UIProgressView*) progress//Reference to the timer progress bar in the question window
											   :(NSArray*) questionButtons;//Holds a list of the question button references

-(IBAction)selectChoice:(id)sender;//Called when a choice has been selected, handles selecting/deselecting the choice
-(NSMutableArray*)select10Questions:(NSMutableArray*) questionList;//After parsing the document, we will only select 10 random questions
-(NSUInteger) getMaxNumberOfChoiceSelections:(NSArray*) points;//This function determines the number of choices the student can select for a given questions
-(IBAction)nextQuestion:(id)sender;//validates the question when user presses 'Next'
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;//Called whenever a button is pressed on an alert window, handles loading next question and quitting the game
-(void)loadQuestionFromIndex:(NSUInteger) index;//Loads a question from a given index
-(int)calculateTotalScore:(NSArray*) points;//Calculates the total score for this entire quiz
-(void)resetAllButtons;//Resets buttons back to normal non-higlighted state
-(void)updateTimer;//fired every 1 second, checks whether time is up
-(void)quitGame;//Removes questionScreen from the mainview
-(void)stopTimer;//Stop timer from view controller
-(UIButton *) buttonCreator:(NSString*) text buttonX:(CGFloat)ix buttonY:(CGFloat)iy;
-(void)selectword:(id)sender;
@end
