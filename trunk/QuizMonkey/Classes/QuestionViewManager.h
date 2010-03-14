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
	IBOutlet UILabel *questionSentenceLabel;//Reference to the sentence label
	IBOutlet UILabel *questionSentenceBottomLabel;//Reference to the sentence label below the question image
	IBOutlet UILabel *questionTypeLabel;//Displays the type of question
	IBOutlet UIImageView *questionImage;//Displays the image of the question, if any
	NSArray* questionChoiceButtons;//Holds all of the choice buttons
	
	
	NSMutableArray* questionList;//Holds the list of questions
	NSUInteger currentQuestionIndex;//Holds the index of the current queestion
	Question* currentQuestion;//Holds current question object
	NSMutableSet* selectedChoices;//Holds Selected choices
	NSUInteger maxNumberOfChoiceSelections;//Holds the max number of allowable choice selections
	NSUInteger totalPointsForCurrentQuestion;//Holds the total points for current question
	
	UIAlertView *alert;//Holds alert box for displaying score

}

@property (assign) IBOutlet UIView* mainMenuScreen;
@property (assign) IBOutlet UIView* questionScreen;
@property (assign) IBOutlet UILabel *questionSentenceLabel;
@property (assign) IBOutlet UILabel *questionSentenceBottomLabel;
@property (assign) IBOutlet UILabel *questionTypeLabel;
@property (assign) IBOutlet UIImageView *questionImage;
@property (assign) NSArray* questionChoiceButtons;

@property (assign) NSMutableArray* questionList;
@property (assign) NSUInteger currentQuestionIndex;
@property (assign) Question* currentQuestion;
@property (assign) NSMutableSet* selectedChoices;
@property (assign) NSUInteger maxNumberOfChoiceSelections;

-(QuestionViewManager*) initQuestionViewManager:(UIView*) mainView 
											   :(UIView*) questionView 
											   :(UILabel*) sentenceLabel 
											   :(UILabel*) sentenceLabelBottom 
											   :(UILabel*) questionType
											   :(UIImageView*) image 
											   :(NSArray*) questionButtons;

-(IBAction)selectChoice:(id)sender;
-(NSMutableArray*) select10Questions: (NSMutableArray*) questionList;
-(NSUInteger) getMaxNumberOfChoiceSelections: (NSArray*) points;
-(IBAction)nextQuestion:(id)sender;//validates the question when user presses 'Next'
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
-(void) loadQuestionFromIndex: (NSUInteger) index;
-(int) calculateTotalScore: (NSArray*) points;
-(void) resetAllButtons;

@end
