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


@interface QuestionViewManager : NSObject {
	
	IBOutlet UIView *mainMenuScreen;//Holds a reference to the main menu
	IBOutlet UIView *questionScreen;//Will be set as a subview for the main menu
	NSMutableArray* questions;//Holds the list of questions
	NSArray* questionChoiceButtons;//Holds all of the choice buttons
	NSUInteger currentQuestionIndex;//Holds the index of the current queestion
	IBOutlet UILabel *questionSentenceLabel;//Reference to the sentence label
	IBOutlet UILabel *questionSentenceBottomLabel;//Reference to the sentence label below the question image
	IBOutlet UILabel *questionTypeLabel;//Displays the type of question
	IBOutlet UIImageView *questionImage;//Displays the image of the question, if any
	NSMutableSet* selectedChoices;//Holds Selected choices
	NSUInteger maxNumberOfChoiceSelections;//Holds the max number of allowable choice selections

}

@property (assign) IBOutlet UIView* mainMenuScreen;
@property (assign) IBOutlet UIView* questionScreen;
@property (assign) NSMutableArray* questions;
@property (assign) NSArray* questionChoiceButtons;
@property (assign) NSUInteger currentQuestionIndex;
@property (assign) IBOutlet UILabel *questionSentenceLabel;
@property (assign) IBOutlet UILabel *questionSentenceBottomLabel;
@property (assign) IBOutlet UILabel *questionTypeLabel;
@property (assign) IBOutlet UIImageView *questionImage;
@property (assign) NSMutableSet* selectedChoices;
@property (assign) NSUInteger maxNumberOfChoiceSelections;

//-(QuestionViewManager*) initQuestionViewManager: (NSArray*) questionButtons :(UILabel*) sentenceLabel :(UILabel*) sentenceLabelBottom :(UIImageView*) image;

-(IBAction)selectChoice:(id)sender;
-(NSMutableArray*) select10Questions: (NSMutableArray*) questionList;
-(NSUInteger) getMaxNumberOfChoiceSelections: (NSArray*) points;
-(IBAction)nextQuestion:(id)sender;
-(void) loadQuestionFromIndex: (NSUInteger) index;


@end
