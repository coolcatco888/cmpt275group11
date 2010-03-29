//
//  QuestionViewManager.m
//  QuizMonkey
//
//  Created by Cley Tang on 3/12/10.
//
//  Worked on by Cley, Ariel, Tony, Meiko, Daniel
//
//  Known Bugs: See the header file
//
//  Changes: See the header file
//
//  Copyright 2010 Team Awesome. All rights reserved.
//


#import "QuestionViewManager.h"


@implementation QuestionViewManager

@synthesize mainMenuScreen;
@synthesize questionScreen;
@synthesize finalScoreScreen;
@synthesize questionSentenceLabel;
@synthesize questionSentenceBottomLabel;
@synthesize questionTypeLabel;
@synthesize finalScoreLabel;
@synthesize questionImage;
@synthesize timerProgress;
@synthesize questionChoiceButtons;
@synthesize questionWords;
@synthesize buttonWordsView;

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
	
	questionWords = [NSMutableSet setWithCapacity:50];
	
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
		[message appendString:@" points!"];
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
		|| [currentQuestion.type isEqualToString:@"Pick out the words"]
		|| [currentQuestion.type isEqualToString:@"Find the misspelled word"]){
		NSLog(@"Did all dat");
		[questionTypeLabel setText:currentQuestion.type];
		[questionSentenceLabel setText:currentQuestion.sentence];
		[questionSentenceLabel setHidden:FALSE];
		[questionSentenceBottomLabel setHidden:TRUE];
		[questionImage setHidden:TRUE];
				
		for(int i = 0; i < [questionChoiceButtons count]; i++) {
			[((UIButton*)[questionChoiceButtons objectAtIndex:i]) setHidden:FALSE];
		}
		
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
	else if ([currentQuestion.type isEqualToString:@"Match the picture"])
	{
		[questionTypeLabel setText:currentQuestion.type];
		[questionSentenceLabel setHidden:TRUE];
		[questionSentenceBottomLabel setText:currentQuestion.sentence];
		[questionSentenceBottomLabel setHidden:FALSE];
		
		// resize the current image to new image
		UIImage* currImage = [UIImage imageNamed:currentQuestion.image];
		CGSize imageSize = CGSizeMake(150, 150);
		UIGraphicsBeginImageContext(imageSize);
		[currImage drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
		UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
		[questionImage setImage:newImage];
		[questionImage setHidden:FALSE];
		
		for(int i = 0; i < [questionChoiceButtons count]; i++) {
			[((UIButton*)[questionChoiceButtons objectAtIndex:i]) setHidden:FALSE];
		}
		 
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
	else 
	{
		currentQuestion.sentence=@"To get a user’s answer out a given number of choices, the tap screen will be used. The application will use “.jpg” files for displaying graphical aspects of the application";//just for testing
		[questionTypeLabel setText:currentQuestion.type];
		[questionSentenceLabel setHidden:TRUE];
		[questionSentenceBottomLabel setHidden:TRUE];
		[questionImage setHidden:TRUE];
		
		selectedWords=0;
		maxNumberOfChoiceSelections =[currentQuestion.points count];
		totalPointsForCurrentQuestion = [self calculateTotalScore: currentQuestion.points];
		totalPoints += totalPointsForCurrentQuestion;
		//disable all of the choice buttons
		for(int i = 0; i < [questionChoiceButtons count]; i++) {
			[((UIButton*)[questionChoiceButtons objectAtIndex:i]) setHidden:TRUE];
		}
		
		buttonWordsView=[[UIView alloc] initWithFrame:CGRectMake(40, 85, 400, 160)]; 
		[questionScreen addSubview: buttonWordsView];
		[buttonWordsView retain];
		[questionSentenceLabel setText:currentQuestion.sentence];
		
		NSUInteger letterCounter=1;
		NSString* word;
		for(NSUInteger wordIndex=0;wordIndex<[[currentQuestion.sentence componentsSeparatedByString:@" "] count];wordIndex++)
		{
			word=[[currentQuestion.sentence componentsSeparatedByString:@" "] objectAtIndex:wordIndex];
			
			
			int ix= letterCounter % ( 400 / WORD_BUTTON_UNIT_WEIGHT );
			int iy= letterCounter / ( 400 / WORD_BUTTON_UNIT_WEIGHT );
			if (ix+[word length]>( 400 / WORD_BUTTON_UNIT_WEIGHT ))
			{
				ix=0;
				letterCounter=(iy+1)*( 400 / WORD_BUTTON_UNIT_WEIGHT );
				iy++;
			}
			
			
			[questionWords addObject:[self buttonCreator: [NSString stringWithFormat:@"%@", word]  buttonX:(CGFloat)ix buttonY: (CGFloat)iy]];
			letterCounter=letterCounter+([word length]);
		}
		//[questionWords count];
		
		
		[questionWords removeAllObjects];
		
		[questionWords retain];
		
	}

	
	[questionList retain];
}
-(UIButton *) buttonCreator:(NSString*) text buttonX:(CGFloat)CustomizeX buttonY:(CGFloat)CustomizeY{
	
	CGFloat buttonWidth=(WORD_BUTTON_UNIT_WEIGHT)*([text length]);
	UIButton *wordButton;
	//wordButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
	wordButton=[UIButton buttonWithType:UIButtonTypeCustom];
	[wordButton setFrame: CGRectMake((CustomizeX*WORD_BUTTON_UNIT_WEIGHT), (CustomizeY*WORD_BUTTON_UNIT_HEIGHT),buttonWidth ,WORD_BUTTON_UNIT_HEIGHT)];
	[wordButton setTitle:text forState:UIControlStateNormal];
	[wordButton setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
	//[wordButton.titleLabel setTextColor:[UIColor yellowColor]];
	wordButton.titleLabel.font=[UIFont boldSystemFontOfSize:WORD_BUTTON_FONT_SIZE];
	
	//[wordButton.titleLabel adjustsFontSizeToFitWidth];
	[wordButton addTarget:self action:@selector(selectword:) forControlEvents:UIControlEventTouchUpInside];
	[buttonWordsView addSubview:wordButton];
	[wordButton setShowsTouchWhenHighlighted:TRUE];
	//[wordButton retain];
	return wordButton;
}
-(void)selectword:(id)sender
{
	//[sender.titleLabel setTextColor:[UIColor yellowColor]];
	//[sender setHighlighted:TRUE];
	UIButton* currentWord=sender;
	if(currentWord.selected==TRUE) 
	{
		
			//removeObject:currentSelection];
		[currentWord setSelected:FALSE];
		selectedWords--;
		for(int i = 0; i < [currentQuestion.choices count]; i++) 
		{
			NSString* choiceText=[currentQuestion.choices objectAtIndex:i];
			if ([choiceText compare:currentWord.titleLabel.text]==NSOrderedSame)
			{
				NSNumber* currentSelection = [NSNumber numberWithInt:i];
				[selectedChoices removeObject:currentSelection];
				
			}
		}
	}
	else if (selectedWords < maxNumberOfChoiceSelections) 
	{
		[currentWord setSelected:TRUE];
		selectedWords++;
		for(int i = 0; i < [currentQuestion.choices count]; i++) 
		{
			NSString* choiceText=[currentQuestion.choices objectAtIndex:i];
			if ([choiceText compare:currentWord.titleLabel.text]==NSOrderedSame)
			{
				NSNumber* currentSelection = [NSNumber numberWithInt:i];
				[selectedChoices addObject:currentSelection];
				
			}
		}
	}
	
	
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
	}
	[monkeyImage setHidden:TRUE];
	[questionChoiceButtons retain];
	
	[buttonWordsView removeFromSuperview];
	

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
	//[buttonWordsView release];
	[self resetAllButtons];
}

-(void) stopTimer {
	[timer invalidate];
}
@end
