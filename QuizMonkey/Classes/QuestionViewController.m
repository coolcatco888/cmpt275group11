//
//  QuestionViewController.m
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

#import "QuestionViewController.h"


@implementation QuestionViewController

@synthesize mainMenuView;
@synthesize questionView;
@synthesize finalScoreView;

@synthesize questionListOfQuiz;


@synthesize questionSentenceLabel;
//@synthesize questionSentenceBottomLabel;
@synthesize questionTitleLabel;
@synthesize finalScoreLabel;
@synthesize questionImage;
@synthesize questionTimerProgress;
//@synthesize questionChoiceButtons;
//@synthesize questionWords;
@synthesize buttonWordsView;

@synthesize rewardIconFileName;
@synthesize rewardButtons;
//@synthesize questionList;
@synthesize currentQuestionIndex;
@synthesize currentQuestion;
@synthesize selectedChoices;
@synthesize maxNumberOfChoiceSelections;
@synthesize totalPointsAcquired;

@synthesize finalScore;


- init {
	questionChoiceButtonArray = [NSArray arrayWithObjects:questionChoice1Button, questionChoice2Button, questionChoice3Button, questionChoice4Button, nil];
	
	[questionTimerProgress setProgress:1.0];
	totalPoints = 0;
	instructionsGiven = FALSE;
	quitting = FALSE;
	
	//Setup variables
	selectedChoices = [NSMutableSet setWithCapacity:20];//Used to be 4 but not sure if picking out words questions have more than 4 choices
	totalPointsAcquired = 0;
	
	currentQuestionIndex = 0;
	//Parse XML
	[self loadQuestionsFromXML];
	//Randomly select 10 questions and Display the questionScreen
	[self loadQuizQuestions];
	[self randomizeChoices];
	//Load the first question onto the questionView
	[self loadQuestionFromIndex:currentQuestionIndex];
	
	
	
	[mainMenuView addSubview:questionView];
	
	//Setup Timer
	timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
	
	//Retain lists
	[questionView retain];
	[selectedChoices retain];
	[questionChoiceButtonArray retain];
	//Set Score Object
	finalScore = [Score new];
	
	//Init final score rewards
	rewardIconFileName=[[NSArray alloc] initWithObjects:@"top_student",@"pass",@"combo5",@"grammar",@"vocabulary",@"cheetchreward",  nil];
	rewardButtons =[NSMutableArray arrayWithCapacity: 6];
	for (NSUInteger i=0; i<[rewardIconFileName count]; i++) {
		[rewardButtons addObject:[self rewardIconCreator:[rewardIconFileName objectAtIndex:i] iconX:i%([rewardIconFileName count]/2) iconY:(i/([rewardIconFileName count]/2))]];
	}
	[rewardButtons retain];
	
	
	//display instructions
	[timer invalidate];
	[questionProfMonkeyImage setHidden:FALSE];
	instructionsAlert = [[UIAlertView alloc] initWithTitle:@"Instructions" 
												   message:@"You will be asked 10 questions on spelling and grammar.\nClick the answers on the screen then click 'Next' to proceed to the next question.\nFor some questions you must select multiple choices to get full marks.\nClick on any one of your answers a second time to deselect it.\nGood Luck"
												  delegate:self 
										 cancelButtonTitle:@"Continue" 
										 otherButtonTitles:nil];
	[instructionsAlert show];
	[instructionsAlert autorelease];

	
	return self;
}
-(UIButton*) rewardIconCreator:(NSString*)IconFileName iconX:(NSUInteger)CustomizeX iconY:(NSUInteger)CustomizeY
{
	NSMutableString* image_name_fail = [NSMutableString stringWithCapacity:100];
	[image_name_fail appendString: IconFileName];
	[image_name_fail appendString:@"_fail.png"];
	NSMutableString* image_name_achd = [NSMutableString stringWithCapacity:100];
	[image_name_achd appendString:IconFileName ];
	[image_name_achd appendString:@".png"];
	
	UIButton *iconButton;
	iconButton=[UIButton buttonWithType:UIButtonTypeCustom];
	[iconButton setFrame: CGRectMake((CustomizeX*(REWARD_ICON_SIZE+REWARD_ICON_GAP))+REWARD_ICON_STRAT_POINT_X,(CustomizeY*(REWARD_ICON_SIZE+REWARD_ICON_GAP))+REWARD_ICON_STRAT_POINT_Y,REWARD_ICON_SIZE ,REWARD_ICON_SIZE)];
	[iconButton setBackgroundImage:[UIImage imageNamed: image_name_fail] forState:UIControlStateNormal];
	[iconButton setBackgroundImage:[UIImage imageNamed: image_name_achd] forState:UIControlStateSelected];
	[iconButton addTarget:self action:@selector(rewardDescription:) forControlEvents:UIControlEventTouchUpInside];
	[finalScoreView addSubview:iconButton];
	return iconButton;
}

- (void)loadQuestionsFromXML {
	questionListOfXML = [[QuestionParser new] loadQuestionsFromXML:@"Questions"];
	[questionListOfXML retain];
}
- (void)loadQuizQuestions {
	NSUInteger count = [questionListOfXML count];
	totalNumberOfQuizQuestions = 10;
	totalMaxPoints = 0;
	totalQuizTime = 0;
	totalTime = 0;
	questionListOfQuiz = [NSMutableArray arrayWithCapacity:totalNumberOfQuizQuestions];
	NSUInteger selectedIndex;
	for(NSUInteger i=0; i<count & i<10; i++) {
		// Select a random element between i and end of array to inclide in the quiz array
		selectedIndex = (arc4random() % [questionListOfXML count]);
		[questionListOfQuiz addObject:[questionListOfXML objectAtIndex:selectedIndex]];
		[questionListOfXML removeObjectAtIndex:selectedIndex];
		totalTime += [[questionListOfQuiz objectAtIndex:i] time];
	}
	totalTimeLeft = totalTime;
	[questionListOfQuiz retain];
}
- (void)randomizeChoices {
	for(int i=0;i<10;i++){
		for(int j=0;j<[[[questionListOfQuiz objectAtIndex:i] choices] count];j++){
			int k = arc4random()%[[[questionListOfQuiz objectAtIndex:i] choices] count];
			[[[questionListOfQuiz objectAtIndex:i] choices] exchangeObjectAtIndex:j withObjectAtIndex:k];
			[[[questionListOfQuiz objectAtIndex:i] points] exchangeObjectAtIndex:j withObjectAtIndex:k];
		}
	}
}
- (void)loadNextQuestionToView {
	currentQuestionIndex++;
	currentQuestion = [questionListOfQuiz objectAtIndex:currentQuestionIndex];
	
	if([self questionHasImage])
		questionSentenceLabel.frame = CGRectMake(SENTENCE_RECT_WHEN_IMAGE_X, SENTENCE_RECT_WHEN_IMAGE_Y, SENTENCE_RECT_WHEN_IMAGE_W, SENTENCE_RECT_WHEN_IMAGE_H);
	
	[questionTitleLabel setText:currentQuestion.type];
	if([currentQuestion.type isEqualToString:@"Fill in the blank"]
	   || [currentQuestion.type isEqualToString:@"Pick out the words"]
	   || [currentQuestion.type isEqualToString:@"Find the misspelled word"]){
		[questionSentenceLabel setText:currentQuestion.sentence];
		[questionSentenceLabel setHidden:FALSE];
		for(int i = 0; i < 4; i++) {
			[[questionChoiceButtonArray objectAtIndex:i] setTitle:[currentQuestion.choices objectAtIndex:i] forState:0];
			[[questionChoiceButtonArray objectAtIndex:i] setHidden:FALSE];
		}
		
		currentMaxPoints=0;
		currentMaxSelections=0;
		
		for(int i=0;i<[[currentQuestion points] count];i++){
			currentMaxPoints = [[currentQuestion.points objectAtIndex:i] intValue];
			if([currentQuestion.points objectAtIndex:i]>0)
				currentMaxSelections++;
		}
		
		totalMaxPoints += currentMaxPoints;
	}
	else {
		
	}
	
	
}

- (IBAction)selectChoice:(id)sender {
/*	if(![sender isSelected]) {
		if(currentNumberOfSelections < currentMaxSelections) {
			[sender setSelected:TRUE];
			currentNumberOfSelections++;
		}
	}
	else {
		if(currentNumberOfSelections > 0) {
			[sender setSelected:FALSE];
			currentNumberOfSelections--;
		}
	}
	
*/
	UIButton* buttonPressed = (UIButton*)sender;
	NSString* choice = buttonPressed.titleLabel.text;
	
	NSLog(choice);
	
	for(int i = 0; i < [questionChoiceButtonArray count]; i++) {
		//Match the selected choice with the available choices
		if([choice isEqualToString:((UIButton*)[questionChoiceButtonArray objectAtIndex:i]).titleLabel.text]) {
			
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
- (NSMutableArray*)select10Questions: (NSMutableArray*) questions {
	NSUInteger count = [questions count];
	for (NSUInteger i = 0; i < count; ++i) {
		// Select a random element between i and end of array to swap with.
		int n = (arc4random()%(count-i)) + i;
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
	totalTimeLeft = totalTime;
	return selectedQuestions;
	
	
}
- (NSUInteger)getMaxNumberOfChoiceSelections: (NSArray*) points {
	NSUInteger count = 0;
	for(int i = 0; i < [points count]; i++) {
		if([[points objectAtIndex:i] intValue] > 0) {
			count++;
		}
	}
	return count;
}
- (IBAction)nextQuestion:(id)sender {
	//Pause timer
	[timer invalidate];
	int points = 0;
	[questionProfMonkeyImage setHidden:FALSE];
	NSArray* pointList = currentQuestion.points;
	
	//Add Up total points and add the score to the totalPointsAquired (by student)
	for(id index in selectedChoices) {
		NSNumber* pointIndex = (NSNumber*)index;
		NSNumber* pointValue = (NSNumber*) [pointList objectAtIndex:[pointIndex intValue]];
		points += [pointValue intValue];//Because of the Find the word questions, some choices have negative point values
	}
	if(points < 0)
		points=0;
	totalPointsAcquired += points;
	
	//Display an appropriate message given the results
	NSString* title;
	NSMutableString* message = [NSMutableString stringWithCapacity:100];
	
	//Set message if the student got nothing
	if(points == 0) {
		title = @"Sorry...";
		[message appendString:@"Your answer is completely WRONG!\n"];
		[message appendString:[[NSNumber numberWithInt:points] stringValue]];
		[message appendString:@"/"];
		[message appendString:[[NSNumber numberWithInt:totalPointsForCurrentQuestion] stringValue]];
		[message appendString:@" points!"];
		finalScore.combo=0;
		//Set message if the student got some right
	} else if (points < totalPointsForCurrentQuestion) {
		title = @"Not Bad...";
		[message appendString:@"You got "];
		[message appendString:[[NSNumber numberWithInt:points] stringValue]];
		[message appendString:@"/"];
		[message appendString:[[NSNumber numberWithInt:totalPointsForCurrentQuestion] stringValue]];
		[message appendString:@" points!"];
		finalScore.combo=0;
		//Set Message if the student got all of them right
	} else {
		title = @"Perfect!";
		[message appendString:@"You got "];
		[message appendString:[[NSNumber numberWithInt:points] stringValue]];
		[message appendString:@"/"];
		[message appendString:[[NSNumber numberWithInt:totalPointsForCurrentQuestion] stringValue]];
		[message appendString:@" points!"];
		[finalScore updateCounters:currentQuestion.type];
	}
	
	NSLog(@"max combo: %d, combo: %d.",finalScore.maxCombo,finalScore.combo);
	alert = [[UIAlertView alloc] initWithTitle:title 
									   message:message 
									  delegate:self 
							 cancelButtonTitle:@"Continue" 
							 otherButtonTitles:nil];
	[alert show];
	[alert autorelease];
}

-(void)getReward: (NSUInteger)reward_id
{
	UIButton* temp=[rewardButtons objectAtIndex:reward_id];
	[temp setSelected:TRUE];
	
}
-(void)rewardDescription:(UIButton*)sender
{
	BOOL show_peanut_butter_jelly_time_view=FALSE;
	
	NSString* title;
	NSMutableString* message = [NSMutableString stringWithCapacity:100];
	if (sender==[rewardButtons objectAtIndex:0]) 
	{
		title = @"Top Stduent";
		
		if (sender.selected)
		{
			[message appendString:@"Wow! You got "];
			[message appendString:[[NSNumber numberWithInt:((totalPointsAcquired*100)/totalPoints)] stringValue]];
			[message appendString:@"%. Let's dance!\n\n\n\n\n\n"];
			show_peanut_butter_jelly_time_view=TRUE;
		}
		else
		{
			[message appendString:@"Get 90% or more banana points to get this reward.\nYou got "];
			[message appendString:[[NSNumber numberWithInt:((totalPointsAcquired*100)/totalPoints)] stringValue]];
			[message appendString:@"% this time"];
		}
		
		
	} 
	else if (sender==[rewardButtons objectAtIndex:1])  
	{
		
		title = @"Pass The Quiz";
		if (sender.selected)
		{
			[message appendString:@"You passed this quiz!\nCongratulations!"];
		}
		else
		{
			[message appendString:@"You failed this quiz.\nSuddy more for the next quiz."];
		}
		
		
		
	}
	else if (sender==[rewardButtons objectAtIndex:2]) 
	{
		title = @"Perfect Answer Combo";
		[message appendString:@"Get 5 or more perfect answers in a row to unlock this reward.\nYour longest streak for this quiz was "];
		[message appendString:[[NSNumber numberWithInt: finalScore.maxCombo] stringValue]];
		[message appendString:@" perfect answers in a row"];
	}
	else if (sender==[rewardButtons objectAtIndex:3]) 
	{
		title = @"Grammar Expert";
		[message appendString:@"Get 5 or more perfect answers for grammar questions.\nYou answered "];
		[message appendString:[[NSNumber numberWithInt: finalScore.grammar] stringValue]];
		[message appendString:@" grammar question correctly this time."];
	}
	else if (sender==[rewardButtons objectAtIndex:4])  
	{
		title = @"Vocabulary Master";
		[message appendString:@"Get 5 or more perfect answers for vocabulary questions.\nYou answered "];
		[message appendString:[[NSNumber numberWithInt: finalScore.vocabulary] stringValue]];
		[message appendString:@" vocabulary question correctly this time."];
		
	}
	else if (sender==[rewardButtons objectAtIndex:5]) 
	{
		title = @"Speed Demon";
		if (sender.selected)
		{
			[message appendString:@"Wow! You finish this quiz SOOoooo.... fast!"];
		}
		else
		{
			[message appendString:@"Finish a quiz as fast as you can.\nBut remember, you also need to pass the quiz to get this reward."];
		}
	}
	else
	{
		title = @"Unknow Reward";
		[message appendString:@"Nothing about this reward..."];
		
	}
	
	alert = [[UIAlertView alloc] initWithTitle:title 
									   message:message 
									  delegate:self 
							 cancelButtonTitle:@"Continue" 
							 otherButtonTitles:nil];

	
	
	
	if (show_peanut_butter_jelly_time_view)
	{
		
		UIImageView* peanut_butter_jelly_time_view= [[UIImageView alloc] initWithFrame:CGRectMake(105, 88, 75, 75)];
		
		
		peanut_butter_jelly_time_view.animationImages=[NSArray arrayWithObjects:	[UIImage imageNamed:@"Banana_Frame1.png"],
													   [UIImage imageNamed:@"Banana_Frame2.png"],
													   [UIImage imageNamed:@"Banana_Frame3.png"],
													   [UIImage imageNamed:@"Banana_Frame4.png"],
													   [UIImage imageNamed:@"Banana_Frame5.png"],
													   [UIImage imageNamed:@"Banana_Frame6.png"],
													   [UIImage imageNamed:@"Banana_Frame7.png"],
													   [UIImage imageNamed:@"Banana_Frame8.png"],
													   nil];
		peanut_butter_jelly_time_view.animationDuration = 0.70;
		[peanut_butter_jelly_time_view startAnimating];
		[alert addSubview:peanut_butter_jelly_time_view];
		[peanut_butter_jelly_time_view release]; 
		
	}
	[alert show];
	[alert autorelease];
	
}

- (bool)questionHasImage {
	if([currentQuestion.image isEqualToString:@"\n\t\t"])
		return FALSE;
	return TRUE;
}
- (void)loadQuestionFromIndex: (NSUInteger) index {
	
	//Delete current question in memory and add a new question
	currentQuestion = [questionListOfQuiz objectAtIndex:index];
	[self resetQuestionView];
	
	NSLog(@"New Question Set at Index:%i",index);
//	NSLog([[NSNumber numberWithInt:index] stringValue]);
	
	if([self questionHasImage]) {
		questionSentenceLabel.frame = CGRectMake(SENTENCE_RECT_WHEN_IMAGE_X, SENTENCE_RECT_WHEN_IMAGE_Y, SENTENCE_RECT_WHEN_IMAGE_W, SENTENCE_RECT_WHEN_IMAGE_H);
		[questionImage setImage:[UIImage imageNamed:currentQuestion.image]];
		[questionImage setHidden:FALSE];

	}
	
	
	//Here is where the screen objects are set from the question object
	if([currentQuestion.type isEqualToString:@"Fill in the blank"]
	   || [currentQuestion.type isEqualToString:@"Pick out the words"]
	   || [currentQuestion.type isEqualToString:@"Find the misspelled word"]
		|| [currentQuestion.type isEqualToString:@"Match the picture"]){
		[questionTitleLabel setText:currentQuestion.type];
		[questionSentenceLabel setText:currentQuestion.sentence];
		[questionSentenceLabel setHidden:FALSE];

		
		
		//Set all of the text for the choice buttons
		for(int i = 0; i < [questionChoiceButtonArray count]; i++) {
			[[questionChoiceButtonArray objectAtIndex:i] setTitle:[currentQuestion.choices objectAtIndex:i] forState:0];
			[[questionChoiceButtonArray objectAtIndex:i] setHidden:FALSE];
		}
		
		//Calculate Question Totals
		maxNumberOfChoiceSelections = [self getMaxNumberOfChoiceSelections:currentQuestion.points];
		totalPointsForCurrentQuestion = [self calculateTotalScore: currentQuestion.points];
		totalPoints += totalPointsForCurrentQuestion;
		NSLog(@"Max number od choices:%i",maxNumberOfChoiceSelections);

	}
	else 
	{
		//currentQuestion.sentence=@"To get a user’s answer out a given number of choices, the tap screen will be used. The application will use “.jpg” files for displaying graphical aspects of the application";//just for testing
		[questionTitleLabel setText:currentQuestion.type];
		
		selectedWords=0;
		maxNumberOfChoiceSelections =[currentQuestion.points count];
		totalPointsForCurrentQuestion = [self calculateTotalScore:currentQuestion.points];
		totalPoints += totalPointsForCurrentQuestion;
		
		buttonWordsView=[[UIView alloc] initWithFrame:CGRectMake(40, 85, 400, 160)]; 
		[questionView addSubview: buttonWordsView];
		[buttonWordsView retain];
		[questionSentenceLabel setText:currentQuestion.sentence];
		
		NSUInteger letterCounter=1;
		NSString* word;
		NSArray *sentenceArray = [currentQuestion.sentence componentsSeparatedByString:@" "];
		for(NSUInteger wordIndex=0;wordIndex<[sentenceArray count];wordIndex++)
		{
			word=[sentenceArray objectAtIndex:wordIndex];
			
			
			int ix= letterCounter % ( 400 / WORD_BUTTON_UNIT_WEIGHT );
			int iy= letterCounter / ( 400 / WORD_BUTTON_UNIT_WEIGHT );
			if (ix+[word length]>( 400 / WORD_BUTTON_UNIT_WEIGHT ))
			{
				ix=0;
				letterCounter=(iy+1)*( 400 / WORD_BUTTON_UNIT_WEIGHT );
				iy++;
			}
			
			
			//[questionWords addObject:[self buttonCreator:word  buttonX:(CGFloat)ix buttonY: (CGFloat)iy]];
			[self buttonCreator:word  buttonX:(CGFloat)ix buttonY: (CGFloat)iy];
			letterCounter=letterCounter+([word length]);
		}
		//[questionWords count];
		//[questionWords removeAllObjects];
		//[questionWords retain];
		
		 }
}

- (UIButton *)buttonCreator:(NSString*) text buttonX:(CGFloat)CustomizeX buttonY:(CGFloat)CustomizeY {
	
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
- (void)selectword:(id)sender {
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
			if([self roughCompare:choiceText otherString:currentWord.titleLabel.text])
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
			if([self roughCompare:choiceText otherString:currentWord.titleLabel.text])
			{
				NSNumber* currentSelection = [NSNumber numberWithInt:i];
				[selectedChoices addObject:currentSelection];
				
			}
		}
	}
	
	
}

- (BOOL) roughCompare: (NSString*) str1 otherString: (NSString*) str2{
	str1 = [str1 lowercaseString];
	str1 = [str1 stringByReplacingOccurrencesOfString:@"," withString:@""];
	str1 = [str1 stringByReplacingOccurrencesOfString:@"." withString:@""];
	str1 = [str1 stringByReplacingOccurrencesOfString:@"!" withString:@""];
	str1 = [str1 stringByReplacingOccurrencesOfString:@"(" withString:@""];
	str1 = [str1 stringByReplacingOccurrencesOfString:@")" withString:@""];
	
	str2 = [str2 lowercaseString];
	str2 = [str2 stringByReplacingOccurrencesOfString:@"," withString:@""];
	str2 = [str2 stringByReplacingOccurrencesOfString:@"." withString:@""];
	str2 = [str2 stringByReplacingOccurrencesOfString:@"!" withString:@""];
	str2 = [str2 stringByReplacingOccurrencesOfString:@"(" withString:@""];
	str2 = [str2 stringByReplacingOccurrencesOfString:@")" withString:@""];
	
	if ([str2 compare:str1]==NSOrderedSame)
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
	
}
- (int)calculateTotalScore:(NSArray*)points {
	
	int totalScore = 0;
	for(NSNumber* point in points) {
		totalScore += [point intValue] < 0? 0 : [point intValue];
	}
	return totalScore;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if(quitting) {
		if(buttonIndex == yesButton){
			[self quitGame];	
		}
	}
		//Reset Question Screen
	if(!quitting && instructionsGiven) {
		[self resetQuestionView];
		[selectedChoices removeAllObjects];
	}
	
	switch(buttonIndex) {
		case 0:	
			if(totalTimeLeft == 0) {
				//Exit Quiz Session
				[self quitGame];
				//Load Next Question if the index is less than the number of questions - 1 (since it is zero indexed)
			} else if((currentQuestionIndex < [questionListOfQuiz count] - 1) && !quitting & instructionsGiven){
				currentQuestionIndex++;
				[self loadQuestionFromIndex:currentQuestionIndex];
				timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
				//If we have reached the end of the questions	

			} else if(quitting){
				[questionProfMonkeyImage setHidden:TRUE];
				quitting = FALSE;
				timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];

			}else if(!instructionsGiven) {
				instructionsGiven = TRUE;		
				[questionProfMonkeyImage setHidden:TRUE];
				timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
				
			} else if (currentQuestionIndex == [questionListOfQuiz count] - 1) {
				//Quit game and show final score screen
				[self quitGame];
				[mainMenuView addSubview:finalScoreView];
				
				//Set final score on finalScoreScreen
				NSMutableString* score = [NSMutableString stringWithCapacity:100];
				[score appendString:@"You got "];
				[score appendString:[[NSNumber numberWithInt:totalPointsAcquired] stringValue]];
				[score appendString:@" out of "];
				[score appendString:[[NSNumber numberWithInt:totalPoints] stringValue]];
				[score appendString:@" banana points!"];
				[finalScoreLabel setText:score];
				
				//Set Score Object
				//finalScore = [Score new];
				[finalScore setPoints:totalPointsAcquired];
				[finalScore setMaxPoints:totalPoints];
				[finalScore setTimeLeft:totalTimeLeft];
				
				//check to see Achievement
				
				if (((totalPointsAcquired*100)/totalPoints)>=50)
				{	
					[self getReward:1];
					finalScore.reward1=TRUE;
					if (((totalPointsAcquired*100)/totalPoints)>=90)
					{
						[self getReward:0];
						finalScore.reward0=TRUE;
					}
					
					if (totalTimeLeft*2 >= totalTime)
					{
						[self getReward:5];
						finalScore.reward5=TRUE;
					}
				}
				if (finalScore.maxCombo>=5)
				{
					[self getReward:2];
					finalScore.reward2=TRUE;
				}
				if (finalScore.grammar>=5)
				{
					[self getReward:3];
					finalScore.reward3=TRUE;
				}
				if (finalScore.vocabulary>=5)
				{
					[self getReward:4];
					finalScore.reward4=TRUE;
				}
				
				
				
//				[self release];
			}
		break;
	}
	quitting = FALSE;
}
- (void)resetQuestionView {
	questionSentenceLabel.frame = CGRectMake(SENTENCE_RECT_X, SENTENCE_RECT_Y, SENTENCE_RECT_W, SENTENCE_RECT_H);
	[questionSentenceLabel setHidden:TRUE];
	[questionImage setHidden:TRUE];
	[questionProfMonkeyImage setHidden:TRUE];
	
	for(int i = 0; i < [questionChoiceButtonArray count]; i++) {
		//Set state back to normal
		[[questionChoiceButtonArray objectAtIndex:i] setHidden:TRUE];
		[[questionChoiceButtonArray objectAtIndex:i] setSelected:FALSE];
	}
	[buttonWordsView removeFromSuperview];
}
- (void)updateTimer {
	NSLog(@"Time:%i, TOTALTime:%i",totalTimeLeft,totalTime);
	//Decrement by one second at a time
	totalTimeLeft--;
	//Update timer bar
	[questionTimerProgress setProgress: ((float) totalTimeLeft / (float) totalTime)];
	//If the student ran out of time, exit to the main menu
	if (totalTimeLeft == 0) {
		[timer invalidate];
		[questionProfMonkeyImage setHidden:FALSE];
		
		alert = [[UIAlertView alloc] initWithTitle:@"Oh no!!!" 
										   message:@"You ran out of time!" 
										  delegate:self
								 cancelButtonTitle:@"Quit to Main Menu" 
								 otherButtonTitles:nil];
		[alert show];
		[alert autorelease];
	}
	
}
- (void)quitGame {
	[questionView removeFromSuperview];
/*	[questionChoiceButtonArray release];
	
	[questionListOfXML release];
	[questionListOfQuiz release];
	
	[currentQuestion release];
	
	[questionWords release];
	[buttonWordsView release];
	
	[selectedChoices release];




	
	[currentQuestion release];
	
	[questionWords release];
	[buttonWordsView release];


*/
	
	


}
- (void)stopTimer {
	[timer invalidate];
}

-(IBAction)quitButtonPressed:(id)sender {
	quitting = TRUE;
	[timer invalidate];
	[questionProfMonkeyImage setHidden:FALSE];

	
	quitAlert = [[UIAlertView alloc] initWithTitle:@"Quit?" 
									   message:@"Are you sure you want to quit?"
									  delegate:self 
							 cancelButtonTitle:@"No" 
							 otherButtonTitles:nil];
	yesButton = [quitAlert addButtonWithTitle:@"Yes"];
	[quitAlert show];
	[quitAlert autorelease];
	
	//[questionProfMonkeyImage setHidden:TRUE];
	
/*	if(buttonIndex = yesButton)
		[self quitGame];*/
}
@end
