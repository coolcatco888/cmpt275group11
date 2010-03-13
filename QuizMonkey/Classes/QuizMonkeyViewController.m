//
//  QuizMonkeyViewController.m
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 2/15/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//


#import "QuizMonkeyViewController.h"

@implementation QuizMonkeyViewController


////////////////////////Main View Functions
-(IBAction)ShowHighScoresView:(id)sender {
	[mainMenuView addSubview:highScoresView];
}
-(IBAction)ShowQuestionView:(id)sender {
	QuestionParser * quiz = [QuestionParser new];
	NSMutableArray* questionLibrary = [quiz loadQuestionsFromXML:@"Questions"];
	selectedChoices = [NSMutableSet setWithCapacity:4];
	questionChoiceButtons = [NSArray arrayWithObjects: questionChoice1Button, questionChoice2Button, questionChoice3Button, questionChoice4Button, nil]; 
	[selectedChoices retain];
	[questionChoiceButtons retain];
	
	//Randomly select 10 questions
	questionList = [self select10Questions:questionLibrary];
	currentQuestionIndex = 0;
	[self loadQuestionFromIndex:currentQuestionIndex];
	
	[mainMenuView addSubview:questionView];
	
	[quiz retain];
}
-(IBAction)ShowAlert:(id)sender {
	//First we set all the parameters of the Alert pop-up
	alr_Alert = [[UIAlertView alloc] initWithTitle:@"You win" message:@"You got 0/10" delegate:nil cancelButtonTitle:@"Continue???" otherButtonTitles:nil];
	//Then we SHOW the alert... simple
	[alr_Alert show];
}


////////////////////////Question View Functions
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
	[selectedChoices retain];
}

-(IBAction)exitQuestionView:(id)sender {
	//Removing subview
	[questionView removeFromSuperview];
}

-(IBAction)nextQuestion:(id)sender {
	int points = 0;
	Question* question = (Question*)[questionList objectAtIndex:currentQuestionIndex];
	for(id index in selectedChoices) {
		NSNumber* pointIndex = (NSNumber*)index;
		points += [[question.points objectAtIndex:[pointIndex intValue]] intValue];
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
	[message appendString:[[NSNumber numberWithInt:totalPoints] stringValue]];
	[message appendString:@"!"];
	
	
	alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Go to next question." otherButtonTitles:nil];
	//Then we SHOW the alert... simple
	[alert show];
	
}

-(int) calculateTotalScore: (NSArray*) points {
	
	int totalScore = 0;
	for(NSNumber* point in points) {
		totalScore += [point intValue];
	}
	return totalScore;
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
		
		totalPoints = [self calculateTotalScore: question.points];
		NSLog(@"Max Points allowable is:");
		NSLog([[NSNumber numberWithInt:maxNumberOfChoiceSelections] stringValue]);
	} else if(currentQuestionIndex < [questionList count]) {
		currentQuestionIndex++;
		[self loadQuestionFromIndex:currentQuestionIndex];
	}
	[questionList retain];
	[question release];
	
	
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


////////////////////////High Scores View Functions
-(IBAction)ExitHighScoresView:(id)sender {
	[highScoresView removeFromSuperview];
}


-(IBAction)SetCell:(id)sender {

}


 



-(void)touchesBegan: (NSSet *)touches withEvent:(UIEvent *)event {
	TapLocation = [[[event allTouches] anyObject] locationInView:mainMenuView];
}
-(void)touchesMoved: (NSSet *)touches withEvent:(UIEvent *)event {
	CGPoint TapLocationNew = [[[event allTouches] anyObject] locationInView:mainMenuView];
	
	//Applying the displacement to the center of the screen, moving it up and down
	highScoresView.center = CGPointMake(highScoresView.center.x , highScoresView.center.y - (TapLocation.y - TapLocationNew.y));
	
	//Seting the boundaries so the high scores can't go off the screen
	if(highScoresView.center.y > 300)
		highScoresView.center = CGPointMake(highScoresView.center.x , 300);
	if(highScoresView.center.y < 0)
		highScoresView.center = CGPointMake(highScoresView.center.x , 0);
	
	//Updating the user's tap location
	TapLocation = TapLocationNew;
	
	//NSLog(@"Y: %f", TapLocationNew.y);

}
-(void)touchesEnded: (NSSet *)touches withEvent:(UIEvent *)event {
	TapLocation = [[[event allTouches] anyObject] locationInView:mainMenuView];
	newButton.center = [[[event allTouches] anyObject] locationInView:mainMenuView];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}




//////////////////////////////////////BEGINING of table section
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	
	//[cell setTextLabel:[[UILabel alloc] initWithFrame:CGRectZero];
	//[cell setText:@"What"];

	//Must create a button object
	UIButton *btn_Temp;
	btn_Temp = [UIButton buttonWithType:UIButtonTypeRoundedRect];

	//Just setong the frame (x,y,Width,Height)
	btn_Temp.frame = CGRectMake(0,0,480,43);
	
	//Set the Title of the button, MUST NOT FORGET "forState"
	[btn_Temp setTitle:@"Student Name...................................................................................................................Score, 40/60" forState:UIControlStateNormal];
	
	//Maximum length of text that can fit in the IPhone's 480 wide button:
	//...................................................................................................................
	
	//Setting which function will be called when button pressed
	//addTarget is not really needed and I don't know what @selector is for
	//[btn_New addTarget:self action:@selector(NewButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	
	//Then add the button to the current view as a subview
	[cell addSubview:btn_Temp];
	[btn_Temp retain];
	
//	cell.text = @"What.................................................................................................40/60";
	
    return cell;
}
///////////////////////////////////////END of teble section



- (void)dealloc {
	[mainMenuView release];
	[questionView release];
	[highScoresView release];
	[playButton release];
	[quitButton release];
	[newButton release];
	[monkeyImage release];
	[alr_Alert release];
    [super dealloc];
}

@end
