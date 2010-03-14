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
											   :(UIView*) finalScoreView 
											   :(UILabel*) sentenceLabel 
											   :(UILabel*) sentenceLabelBottom 
											   :(UILabel*) questionType
											   :(UILabel*) finalScore
											   :(UIImageView*) image 
											   :(UIImageView*) monkey
											   :(UIProgressView*) progress
											   :(NSArray*) questionButtons {
	self = [super init];
	
	//Setup from parameters
	mainMenuScreen = mainView;
	questionScreen = questionView;
	finalScoreScreen = finalScoreView;
	questionSentenceLabel = sentenceLabel;
	questionSentenceBottomLabel = sentenceLabelBottom;
	questionTypeLabel = questionType;
	finalScoreLabel = finalScore;
	questionImage = image;
	questionChoiceButtons = questionButtons; 
	monkeyImage = monkey;
	timerProgress = progress;
	
	[timerProgress setProgress:1.0];
	
	//Parse XML
	QuestionParser * parser = [QuestionParser new];
	NSMutableArray* questionLibrary = [parser loadQuestionsFromXML:@"Questions"];
	
	//Setup variables
	selectedChoices = [NSMutableSet setWithCapacity:4];
	totalPointsAcquired = 0;
	
	//Randomly select 10 questions and Display the questionScreen
	questionList = [self select10Questions:questionLibrary];
	currentQuestionIndex = 0;
	[self loadQuestionFromIndex:currentQuestionIndex];
	[mainMenuScreen addSubview:questionScreen];
	
	//Setup Timer
	timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];

	//Retain lists
	[questionScreen retain];
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
	
	//If the xml file contains less than 10 questions then iterate only through < 10 questions
	NSUInteger size = [questions count] < 10? [questions count] : 10;
	totalPoints = 0;
	totalTime = 0;
	NSMutableArray* selectedQuestions = [NSMutableArray arrayWithCapacity:size];
	for(NSUInteger i = 0; i < size; i++) {
		[selectedQuestions addObject:[questions objectAtIndex:i]];
		totalTime += ((Question*)[questions objectAtIndex:i]).time;
	}
	currentTimeLeft = totalTime;
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
	//Pause timer
	[timer invalidate];
	int points = 0;
	[monkeyImage setHidden:FALSE];
	NSArray* pointList = currentQuestion.points;
	
	//Add Up total points and add the score to the totalPointsAquired (by student)
	for(id index in selectedChoices) {
		NSNumber* pointIndex = (NSNumber*)index;
		NSNumber* pointValue = (NSNumber*) [pointList objectAtIndex:[pointIndex intValue]];
		points += [pointValue intValue];
	}
	totalPointsAcquired += points;
	
	//Display an appropriate message given the reslults
	NSString* title;
	NSMutableString* message = [NSMutableString stringWithCapacity:100];
	
	//Set message if the student got nothing
	if(points == 0) {
		title = @"Sorry...";
		[message appendString:@"Your answer is completely WRONG!"];
	//Set message if the student got some right
	} else if (points < totalPointsForCurrentQuestion) {
		title = @"Not Bad...";
		[message appendString:@"You got "];
		[message appendString:[[NSNumber numberWithInt:points] stringValue]];
		[message appendString:@"/"];
		[message appendString:[[NSNumber numberWithInt:totalPointsForCurrentQuestion] stringValue]];
		[message appendString:@"!"];
	//Set Message if the student got all of them right
	} else {
		title = @"Perfect!";
		[message appendString:@"Your answer is correct!"];
	}
	
	
	
	alert = [[UIAlertView alloc] initWithTitle:title 
									   message:message 
									  delegate:self 
							 cancelButtonTitle:@"Continue" 
							 otherButtonTitles:nil];
	[alert show];
	[alert autorelease];
}

-(void) loadQuestionFromIndex: (NSUInteger) index {
	//Delete current question in memory and add a new question
	[currentQuestion release];
	currentQuestion = (Question*) [questionList objectAtIndex:index];
	NSLog(@"New Question Set at Index:");
	NSLog([[NSNumber numberWithInt:index] stringValue]);
	
	//Here is where the screen objects are set from the question object
	if([currentQuestion.type isEqualToString:@"Fill in the blank"]
		|| [currentQuestion.type isEqualToString:@"Pick Out the Words"]) {
		NSLog(@"Did all dat");
		[questionTypeLabel setText:currentQuestion.type];
		[questionSentenceLabel setText:currentQuestion.sentence];
		[questionSentenceLabel setHidden:FALSE];
		[questionSentenceBottomLabel setHidden:TRUE];
		[questionImage setHidden:TRUE];
		
		//Set all of the text for the choice buttons
		for(int i = 0; i < [questionChoiceButtons count]; i++) {
			[((UIButton*)[questionChoiceButtons objectAtIndex:i]) setTitle:[currentQuestion.choices objectAtIndex:i] forState:0];
		}
		
		//Calculate Question Totals
		maxNumberOfChoiceSelections = [self getMaxNumberOfChoiceSelections:currentQuestion.points];
		totalPointsForCurrentQuestion = [self calculateTotalScore: currentQuestion.points];
		totalPoints += totalPointsForCurrentQuestion;
		NSLog(@"Max Points allowable is:");
		NSLog([[NSNumber numberWithInt:maxNumberOfChoiceSelections] stringValue]);
	}
	
	[questionList retain];
}

-(int) calculateTotalScore: (NSArray*) points {
	
	int totalScore = 0;
	for(NSNumber* point in points) {
		totalScore += [point intValue];
	}
	return totalScore;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	//Reset Question Screen
	[self resetAllButtons];
	[selectedChoices removeAllObjects];
	switch(buttonIndex) {
		case 0:	
			if(currentTimeLeft == 0) {
				//Exit Quiz Session
				[self quitGame];
			//Load Next Question if the index is less than the number of questions - 1 (since it is zero indexed)
			} else if(currentQuestionIndex < [questionList count] - 1) {
				NSLog(@"Next Question");
				currentQuestionIndex++;
				[self loadQuestionFromIndex:currentQuestionIndex];
				timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
			//If we have reached the end of the questions
			} else if (currentQuestionIndex == [questionList count] - 1) {
				//Quit game and show final score screen
				[self quitGame];
				[mainMenuScreen addSubview:finalScoreScreen];
				
				//Set final score on finalScoreScreen
				NSMutableString* score = [NSMutableString stringWithCapacity:100];
				[score appendString:@"You got "];
				[score appendString:[[NSNumber numberWithInt:totalPointsAcquired] stringValue]];
				[score appendString:@" out of "];
				[score appendString:[[NSNumber numberWithInt:totalPoints] stringValue]];
				[score appendString:@" banana points!"];
				[finalScoreLabel setText:score];
				
			}
			break;
	}
}

-(void) resetAllButtons {
	for(int i = 0; i < [questionChoiceButtons count]; i++) {
		//Set state back to normal
		[((UIButton*)[questionChoiceButtons objectAtIndex:i]) setSelected:FALSE];
		[monkeyImage setHidden:TRUE];
	}
	[questionChoiceButtons retain];
}
-(void) updateTimer {
	//Decrement by one second at a time
	currentTimeLeft--;
	//Update timer bar
	[timerProgress setProgress: ((float) currentTimeLeft / (float) totalTime)];
	//If the student ran out of time, exit to the main menu
	if (currentTimeLeft == 0) {
		[timer invalidate];
		[monkeyImage setHidden:FALSE];
		
		alert = [[UIAlertView alloc] initWithTitle:@"Oh no!!!" 
										   message:@"You ran out of time!" 
										  delegate:self 
								 cancelButtonTitle:@"Quit to Main Menu" 
								 otherButtonTitles:nil];
		[alert show];
		[alert autorelease];
	}
	
}
-(void) quitGame {
	[questionScreen removeFromSuperview];
	[self resetAllButtons];
}

@end
