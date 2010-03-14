//
//  QuestionViewManager.m
//  QuizMonkey
//
//  Created by Cley Tang on 3/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QuestionViewManager.h"


@implementation QuestionViewManager

@synthesize mainMenuScreen;
@synthesize questionScreen;
@synthesize questionSentenceLabel;
@synthesize questionSentenceBottomLabel;
@synthesize questionTypeLabel;
@synthesize questionImage;
@synthesize questionChoiceButtons;

@synthesize questionList;
@synthesize currentQuestionIndex;
@synthesize currentQuestion;
@synthesize selectedChoices;
@synthesize maxNumberOfChoiceSelections;

-(QuestionViewManager*) initQuestionViewManager:(UIView*) mainView 
											   :(UIView*) questionView 
											   :(UILabel*) sentenceLabel 
											   :(UILabel*) sentenceLabelBottom 
											   :(UILabel*) questionType
											   :(UIImageView*) image 
											   :(NSArray*) questionButtons {
	self = [super init];
	
	//Setup from parameters
	mainMenuScreen = mainView;
	questionScreen = questionView;
	questionSentenceLabel = sentenceLabel;
	questionSentenceBottomLabel = sentenceLabelBottom;
	questionTypeLabel = questionType;
	questionImage = image;
	questionChoiceButtons = questionButtons; 
	
	//Parse XML
	QuestionParser * parser = [QuestionParser new];
	NSMutableArray* questionLibrary = [parser loadQuestionsFromXML:@"Questions"];
	
	//Setup variables
	selectedChoices = [NSMutableSet setWithCapacity:4];
	
	//Randomly select 10 questions
	questionList = [self select10Questions:questionLibrary];
	currentQuestionIndex = 0;
	[self loadQuestionFromIndex:currentQuestionIndex];
	[mainMenuScreen addSubview:questionScreen];

	//Retain lists
	[selectedChoices retain];
	[questionChoiceButtons retain];
	
	return self;
}

-(IBAction) selectChoice:(id)sender {
	UIButton* buttonPressed = (UIButton*)sender;
	NSString* choice = buttonPressed.titleLabel.text;
	
	NSLog(choice);
	
	for(int i = 0; i < [questionChoiceButtons count]; i++) {
		//Match the selected choice with the available choices
		if([choice isEqualToString:((UIButton*)[questionChoiceButtons objectAtIndex:i]).titleLabel.text]) {
			//If this choice is already selected then remove it
			NSNumber* currentSelection = [NSNumber numberWithInt:i];
			
			if([selectedChoices containsObject:currentSelection]) {
				[selectedChoices removeObject:currentSelection];
				[buttonPressed setSelected:FALSE];
				//If the number of selections you have made is still under the amount allowable
				//Then add this as another one of your selections.
			} else if ([selectedChoices count] < maxNumberOfChoiceSelections) {
				[selectedChoices addObject:currentSelection];
				[buttonPressed setSelected:TRUE];
			}
		}
	}
}

- (NSMutableArray*) select10Questions: (NSMutableArray*) questions {
	NSUInteger count = [questions count];
	for (NSUInteger i = 0; i < count; ++i) {
		// Select a random element between i and end of array to swap with.
		int nElements = count - i;
		int n = (random() % nElements) + i;
		[questions  exchangeObjectAtIndex:i withObjectAtIndex:n];
	}
	
	NSUInteger size = [questions count] < 10? [questions count] : 10;
	
	NSMutableArray* selectedQuestions = [NSMutableArray arrayWithCapacity:size];
	for(NSUInteger i = 0; i < size; i++) {
		[selectedQuestions addObject:[questions objectAtIndex:i]];
	}
	
	return selectedQuestions;
	
	
}

-(NSUInteger) getMaxNumberOfChoiceSelections: (NSArray*) points {
	NSUInteger count = 0;
	for(int i = 0; i < [points count]; i++) {
		if([[points objectAtIndex:i] intValue] > 0) {
			count++;
		}
	}
	return count;
}

-(IBAction)nextQuestion:(id)sender {
	int points = 0;
	
	NSArray* pointList = currentQuestion.points;
	
	for(id index in selectedChoices) {
		NSNumber* pointIndex = (NSNumber*)index;
		NSLog(@"---------------------------------- Still GUD");
		NSNumber* pointValue = (NSNumber*) [pointList objectAtIndex:[pointIndex intValue]];
		points += [pointValue intValue];
	}
	
	NSString* title;
	
	if(points == 0) {
		title = @"Sorry...";
	} else {
		title = @"Hurray!";
	}
	
	NSMutableString* message = [NSMutableString stringWithCapacity:100];
	[message appendString:@"You got "];
	[message appendString:[[NSNumber numberWithInt:points] stringValue]];
	[message appendString:@"/"];
	[message appendString:[[NSNumber numberWithInt:totalPointsForCurrentQuestion] stringValue]];
	[message appendString:@"!"];
	
	alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Go to next question." otherButtonTitles:nil];
	[alert show];
}

-(void) loadQuestionFromIndex: (NSUInteger) index {
	currentQuestion = [questionList objectAtIndex:index];
	
	if([currentQuestion.type isEqualToString:@"Fill in the blank"]) {
		[questionTypeLabel setText:currentQuestion.type];
		[questionSentenceLabel setText:currentQuestion.sentence];
		[questionSentenceLabel setHidden:FALSE];
		[questionSentenceBottomLabel setHidden:TRUE];
		[questionImage setHidden:TRUE];
		
		for(int i = 0; i < [questionChoiceButtons count]; i++) {
			[((UIButton*)[questionChoiceButtons objectAtIndex:i]) setTitle:[currentQuestion.choices objectAtIndex:i] forState:0];
		}
		
		maxNumberOfChoiceSelections = [self getMaxNumberOfChoiceSelections:currentQuestion.points];
		
		totalPointsForCurrentQuestion = [self calculateTotalScore: currentQuestion.points];
		NSLog(@"Max Points allowable is:");
		NSLog([[NSNumber numberWithInt:maxNumberOfChoiceSelections] stringValue]);
	} else if(currentQuestionIndex < [questionList count]) {
		currentQuestionIndex++;
		[self loadQuestionFromIndex:currentQuestionIndex];
	}
	
	[questionList retain];
	[currentQuestion release];
}

-(int) calculateTotalScore: (NSArray*) points {
	
	int totalScore = 0;
	for(NSNumber* point in points) {
		totalScore += [point intValue];
	}
	return totalScore;
}

@end
