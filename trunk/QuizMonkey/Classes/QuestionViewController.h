//
//  QuestionViewController.h
//  QuizMonkey
//
//  This class is responsible for displaying the questions on the screen along with managing the game logic
//
//  Created by Cley Tang on 3/12/10.
//
//  Worked on by Cley, Ariel, Tony, Meiko, Daniel
//
//  Known Bugs: 
//   - "Find the words" questions allow you to select all of the words giving the user no penalty for incorrect selections
//
//  Changes:
//   - 1.0 - Implemented
//
//  Tasks:
//   - 1.0 - Create an alert view (with the picture of the monkey) that instructs the student on how to play the game
//           This alert will say, "You will be asked 10 questions on spelling and grammar. Click the answers on the screen then click "Next" to proceed to the next question. 
//           Some questions require you to select multiple answers to obtain all of the points.  Click one of your answers a second time to deselect it before clickng "Next". Good Luck"
//
//  Copyright 2010 Team Awesome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "QuestionParser.h"
#import "Score.h"



//word buttons' setting
#define WORD_BUTTON_FONT_SIZE 20
#define WORD_BUTTON_UNIT_HEIGHT 30
#define WORD_BUTTON_UNIT_WEIGHT  ((12*WORD_BUTTON_FONT_SIZE)/16)

#define SENTENCE_RECT_X 40
#define SENTENCE_RECT_Y 65
#define SENTENCE_RECT_W 400
#define SENTENCE_RECT_H 150
#define SENTENCE_RECT_WHEN_IMAGE_X 40
#define SENTENCE_RECT_WHEN_IMAGE_Y 215
#define SENTENCE_RECT_WHEN_IMAGE_W 400
#define SENTENCE_RECT_WHEN_IMAGE_H 35
#define REWARD_ICON_SIZE 55
#define REWARD_ICON_STRAT_POINT_X 30
#define REWARD_ICON_STRAT_POINT_Y 110
#define REWARD_ICON_GAP 20


//@interface QuestionViewController : UIViewController <UIAlertViewDelegate>

@interface QuestionViewController : UIViewController {
	//View Outlets
	IBOutlet UIView *mainMenuView;//A reference to the main menu view
	IBOutlet UIView *questionView;//A reference to the question view
	IBOutlet UIView *highScoresView;//A reference to the high scores view
	IBOutlet UIView *finalScoreView;//A reference to the final score view
	
	IBOutlet UILabel *questionTitleLabel;
	IBOutlet UILabel *questionSentenceLabel;
	IBOutlet UILabel *questionTimeLabel;
	IBOutlet UILabel *finalScoreLabel;
	
	IBOutlet UIImageView *questionImage;
	IBOutlet UIImageView *questionProfMonkeyImage;
	
	IBOutlet UIProgressView *questionTimerProgress;
	
	IBOutlet UIButton *questionQuitButton;
	IBOutlet UIButton *questionNextButton;
	IBOutlet UIButton *questionChoice1Button;
	IBOutlet UIButton *questionChoice2Button;
	IBOutlet UIButton *questionChoice3Button;
	IBOutlet UIButton *questionChoice4Button;
	NSArray *questionChoiceButtonArray;
	
	NSMutableArray *questionListOfXML;//Holds the list of questions
	NSMutableArray *questionListOfQuiz;
	//NSMutableArray *questionLibrary;
	NSMutableArray *currentWordsArray;
	NSMutableArray *currentPointsArray;
	Question *currentQuestion;
	NSUInteger totalNumberOfQuizQuestions;
	NSUInteger totalQuizTime;
	NSUInteger totalMaxPoints;
	NSUInteger totalTimeLeft;
	NSUInteger currentMaxPoints;
	NSUInteger currentMaxSelections;
	NSUInteger currentScore;
	NSUInteger currentNumberOfSelections;
	NSInteger yesButton;
	BOOL quitting;
	
	NSArray *rewardIconFileName;
	NSMutableArray* rewardButtons;
	
	//Created from constructor
	//	NSArray* questionChoiceButtons;//Holds all of the choice buttons
	//NSMutableArray* questionWords;//a list of word buttons (for find the verb/nouns/adj.)
	UIView* buttonWordsView; 
	NSUInteger selectedWords;
	
	//	NSMutableArray* questionList;//Holds the list of questions
	NSUInteger currentQuestionIndex;//Holds the index of the current queestion
	//	Question* currentQuestion;//Holds current question object
	NSMutableSet* selectedChoices;//Holds Selected choices
	NSUInteger maxNumberOfChoiceSelections;//Holds the max number of allowable choice selections
	NSUInteger totalPointsForCurrentQuestion;//Holds the total points for current question
	NSUInteger totalPoints;//Stores the total points in the quiz
	NSUInteger totalTime;//Stores the total time of the quiz
	NSUInteger totalPointsAcquired;//Stores the total points acquired by the student
	NSTimer* timer;
	UIAlertView *alert;//Holds alert box for displaying score
	Score* finalScore;
}

@property (assign) IBOutlet UIView *mainMenuView;
@property (assign) IBOutlet UIView *questionView;
@property (assign) IBOutlet UIView *finalScoreView;

@property (assign) NSMutableArray* questionListOfQuiz;



@property (assign) IBOutlet UILabel *questionSentenceLabel;
//@property (assign) IBOutlet UILabel *questionSentenceBottomLabel;
@property (assign) IBOutlet UILabel *questionTitleLabel;
@property (assign) IBOutlet UILabel *finalScoreLabel;
@property (assign) IBOutlet UIImageView *questionImage;
@property (assign) IBOutlet UIProgressView *questionTimerProgress;
//@property (assign) NSArray* questionChoiceButtons;
//@property (assign) NSMutableArray* questionWords;
@property (assign) UIView* buttonWordsView; 

@property (assign) NSArray *rewardIconFileName;
@property (assign) NSMutableArray* rewardButtons;
@property (assign) NSUInteger currentQuestionIndex;
@property (assign) Question* currentQuestion;
@property (assign) NSMutableSet* selectedChoices;
@property (assign) NSUInteger maxNumberOfChoiceSelections;
@property (assign) NSUInteger totalPointsAcquired;
@property (assign) Score* finalScore;

/*
 - (int)getTotalScore;
 - (int)getTotalMaxScore;
 - (int)getCurrentMaxNumberOfSelections;
 - (int)getCurrentMaxPoints;
 - (int)getCurrentQuestionScore;
 */
- (bool)questionHasImage;

- (void)resetQuestionView;
- (void)loadNextQuestionToView;/*
 - (void)loadQuestionToView:(NSUInteger)index;*/
- (void)loadQuestionsFromXML;
- (void)loadQuizQuestions;/*
 - (void)selectChoice;
 - (void)deselectChoice;
 - (void)updateTimer;
 - (void)stopTimer;
 
 - (UIButton*)createButton:(NSString*)Title buttonX:(CGFloat)ix buttonY:(CGFloat)iy;
 
 - (IBAction)selectChoice:(id)sender;
 - (IBAction)nextQuestion:(id)sender;
 - (IBAction)exitQuestionView:(id)sender;
 */

-(IBAction)selectChoice:(id)sender;//Called when a choice has been selected, handles selecting/deselecting the choice
-(NSMutableArray*)select10Questions:(NSMutableArray*)questionList;//After parsing the document, we will only select 10 random questions
-(NSUInteger)getMaxNumberOfChoiceSelections:(NSArray*)points;//This function determines the number of choices the student can select for a given questions
-(IBAction)nextQuestion:(id)sender;//validates the question when user presses 'Next'
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;//Called whenever a button is pressed on an alert window, handles loading next question and quitting the game
-(void)loadQuestionFromIndex:(NSUInteger) index;//Loads a question from a given index
-(int)calculateTotalScore:(NSArray*) points;//Calculates the total score for this entire quiz
//-(void)resetAllButtons;//Resets buttons back to normal non-higlighted state
-(void)updateTimer;//fired every 1 second, checks whether time is up
-(void)quitGame;//Removes questionScreen from the mainview
-(void)stopTimer;//Stop timer from view controller
-(UIButton *) buttonCreator:(NSString*) text buttonX:(CGFloat)ix buttonY:(CGFloat)iy;
-(void)selectword:(id)sender;
- (BOOL) roughCompare: (NSString*) str1 otherString: (NSString*) str2;
-(IBAction)quitButtonPressed:(id)sender;
-(void)rewardDescription:(UIButton*)sender;
-(UIButton*) rewardIconCreator:(NSString*) IconFileName iconX:(NSUInteger)CustomizeX iconY:(NSUInteger)CustomizeY;
-(void)getReward:(NSUInteger)reward_id;
@end
