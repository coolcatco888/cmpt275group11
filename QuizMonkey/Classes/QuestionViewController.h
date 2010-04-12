//
//  QuestionViewController.h
//  QuizMonkey
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
//  This class is responsible for displaying the questions on the screen along with managing the game logic
//
//  Copyright 2010 Team Awesome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "QuestionParser.h"
#import "Score.h"

//Button properties for displaying fing the adjectives/nouns/verbs
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

@interface QuestionViewController : UIViewController {
	//View Outlets
	IBOutlet UIView *mainMenuView;//A reference to the main menu view
	IBOutlet UIView *questionView;//A reference to the question view
	IBOutlet UIView *highScoresView;//A reference to the high scores view
	IBOutlet UIView *finalScoreView;//A reference to the final score view
	
	IBOutlet UILabel *questionTitleLabel;//The label used for displaying the question title
	IBOutlet UILabel *questionSentenceLabel;//The label used for displaying the question sentence
	IBOutlet UILabel *questionTimeLabel;//The label used for displaying "Time"
	IBOutlet UILabel *finalScoreLabel;//The label used for displaying the user's final score
	
	IBOutlet UIImageView *questionImage;//The Image view used for displaying the images of some questions
	IBOutlet UIImageView *questionProfMonkeyImage;//The Image view used for displaying professor monkey at the end of each question
	
	IBOutlet UIProgressView *questionTimerProgress;//The progress bar used to show the time left
	
	IBOutlet UIButton *questionQuitButton;//The button used to quit a quiz
	IBOutlet UIButton *questionNextButton;//The button used to finish answering a question
	IBOutlet UIButton *questionChoice1Button;//The button used to dispay the first choice on multiple choice questions
	IBOutlet UIButton *questionChoice2Button;//The button used to dispay the second choice on multiple choice questions
	IBOutlet UIButton *questionChoice3Button;//The button used to dispay the third choice on multiple choice questions
	IBOutlet UIButton *questionChoice4Button;//The button used to dispay the fourth choice on multiple choice questions
	NSArray *questionChoiceButtonArray;//An array containing the previous four references so that they are easyly accessible
	
	NSMutableArray *questionListOfXML;//Holds the list of questions loaded from the XML file
	NSMutableArray *questionListOfQuiz;//Holds only the 10 questions that will be asked on the quiz
	NSMutableArray *currentWordsArray;//Holds an array of the choices for a question
	NSMutableArray *currentPointsArray;//Holds an array of all the points that belong to each choice
	Question *currentQuestion;//The question object being asked
	NSUInteger totalNumberOfQuizQuestions;//The number of questions in the current quiz
	NSUInteger totalQuizTime;//The total maximum time that the quiz allows
	NSUInteger totalMaxPoints;//The total maximum points that a user can achieve
	NSUInteger totalTimeLeft;//The total time left for the current quiz
	NSUInteger currentMaxPoints;//The maximum points for the current question
	NSUInteger currentMaxSelections;//The maximum number of choice selections
	NSUInteger currentScore;//The score for the current question
	NSUInteger currentNumberOfSelections;//The number of choices that the user has selected for the current question
	NSInteger yesButton;//Used for the yes button when quiting a quiz
	BOOL quitting;//A boolean used in the alert view function when quiting
	BOOL instructionsGiven;//A boolean used to know if the instructions of playing have been given already
	
	NSArray *rewardIconFileName;//An array that will contain the filenames of all the reward pictures
	NSMutableArray* rewardButtons;//An array that will contain the button references of the reward images
	
	//Created from constructor
	UIView* buttonWordsView;//A transparent view used for easy modification of Find the noun/adjectives/verbs questions
	NSUInteger selectedWords;//The number of selected word on the tipes of questions above
	
	NSUInteger currentQuestionIndex;//Holds the index of the current queestion
	NSMutableSet* selectedChoices;//Holds Selected choices
	NSUInteger maxNumberOfChoiceSelections;//Holds the max number of allowable choice selections
	NSUInteger totalPointsForCurrentQuestion;//Holds the total points for current question
	NSUInteger totalPoints;//Stores the total points in the quiz
	NSUInteger totalTime;//Stores the total time of the quiz
	NSUInteger totalPointsAcquired;//Stores the total points acquired by the student
	NSTimer* timer;//The timer used for recording the quiztime that has passed
	UIAlertView *alert;//Holds alert box for displaying score
	UIAlertView *instructionsAlert;//the instruction screen
	UIAlertView *quitAlert;//the quit screen
	Score* finalScore;//A score object that will be sent to the OnlineViewController class object so that it is later sent to the QuizMonkey server
}

@property (assign) IBOutlet UIView *mainMenuView;
@property (assign) IBOutlet UIView *questionView;
@property (assign) IBOutlet UIView *finalScoreView;
@property (assign) NSMutableArray* questionListOfQuiz;

@property (assign) IBOutlet UILabel *questionSentenceLabel;
@property (assign) IBOutlet UILabel *questionTitleLabel;
@property (assign) IBOutlet UILabel *finalScoreLabel;
@property (assign) IBOutlet UIImageView *questionImage;
@property (assign) IBOutlet UIProgressView *questionTimerProgress;

@property (assign) UIView* buttonWordsView; 

@property (assign) NSArray *rewardIconFileName;
@property (assign) NSMutableArray* rewardButtons;
@property (assign) NSUInteger currentQuestionIndex;
@property (assign) Question* currentQuestion;
@property (assign) NSMutableSet* selectedChoices;
@property (assign) NSUInteger maxNumberOfChoiceSelections;
@property (assign) NSUInteger totalPointsAcquired;
@property (assign) Score* finalScore;

- (bool)questionHasImage;//Used to check if a question has an image to be displayed
- (void)resetQuestionView;//Resets the question View so that a new question can be loaded
- (void)loadQuestionsFromXML;//Load all the questions from an xml file
- (void)loadQuizQuestions;//Load the 10 questions that will be asked on the quiz

- (IBAction)selectChoice:(id)sender;//Called when a choice has been selected, handles selecting/deselecting the choice
- (NSMutableArray*)select10Questions:(NSMutableArray*)questionList;//After parsing the document, we will only select 10 random questions
- (NSUInteger)getMaxNumberOfChoiceSelections:(NSArray*)points;//This function determines the number of choices the student can select for a given questions
- (IBAction)nextQuestion:(id)sender;//validates the question when user presses 'Next'
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;//Called whenever a button is pressed on an alert window, handles loading next question and quitting the game
- (void)randomizeChoices;//Makes the order of the choices random
- (void)loadQuestionFromIndex:(NSUInteger) index;//Loads a question from a given index
- (int)calculateTotalScore:(NSArray*) points;//Calculates the total score for this entire quiz
- (void)updateTimer;//fired every 1 second, checks whether time is up
- (void)quitGame;//Removes questionScreen from the mainview
- (void)stopTimer;//Stop timer from view controller
- (UIButton *) buttonCreator:(NSString*) text buttonX:(CGFloat)ix buttonY:(CGFloat)iy;//this function is to create a button for grammar questions
- (void)selectword:(id)sender;//this function will be called when the user click a word in grammar questions. it will change the word's color and make it is selected
- (BOOL) roughCompare: (NSString*) str1 otherString: (NSString*) str2;//this function can compare two strings without punctuations and letter cases.
- (IBAction)quitButtonPressed:(id)sender;//quit the quiz when user presses 'Quit'
- (void)rewardDescription:(UIButton*)sender;//display rewards' Descriptions when user presses that reward icon
- (UIButton*) rewardIconCreator:(NSString*) IconFileName iconX:(NSUInteger)CustomizeX iconY:(NSUInteger)CustomizeY;//create a reward icon in the final score view
- (void)getReward:(NSUInteger)reward_id;//give the reward to user then the user achieved the condition
@end
