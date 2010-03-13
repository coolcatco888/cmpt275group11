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
@synthesize questions;
@synthesize questionChoiceButtons;
@synthesize currentQuestionIndex;
@synthesize questionSentenceLabel;
@synthesize questionSentenceBottomLabel;
@synthesize questionTypeLabel;
@synthesize questionImage;
@synthesize selectedChoices;
@synthesize maxNumberOfChoiceSelections;
/*

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
	
	
	
}

-(void) loadQuestionFromIndex: (NSUInteger) index {
	Question* question = [questionList objectAtIndex:index];
	
	if([question.type isEqualToString:@"Fill in the blank"]) {
		[questionTypeLabel setText:question.type];
		[questionSentenceLabel setText:question.sentence];
		[questionSentenceLabel setHidden:FALSE];
		[questionSentenceBottomLabel setHidden:TRUE];
		[questionImage setHidden:TRUE];
		
		for(int i = 0; i < [questionChoiceButtons count]; i++) {
			[((UIButton*)[questionChoiceButtons objectAtIndex:i]) setTitle:[question.choices objectAtIndex:i] forState:0];
		}
		
		maxNumberOfChoiceSelections = [self getMaxNumberOfChoiceSelections:question.points];
		NSLog(@"Max Points allowable is:");
		NSLog([[NSNumber numberWithInt:maxNumberOfChoiceSelections] stringValue]);
	} else if(currentQuestionIndex < [questionList count]) {
		currentQuestionIndex++;
		[self loadQuestionFromIndex:currentQuestionIndex];
	}
	
	[question release];
	
	
}
 */
@end
