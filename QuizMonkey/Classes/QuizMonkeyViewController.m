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
-(void) selectChoice:(id)sender {
	NSString* choice = ((UIButton*) sender).titleLabel;
	Question* question = [questionList objectAtIndex:index];
	for(int i = 0; i < [question.choices count]; i++) {

	}
	//[(UIButton*)sender removeFromSuperview];
	
}

-(IBAction)ExitQuestionView:(id)sender {
	//Removing subview
	[questionView removeFromSuperview];
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
		[questionChoice1Button setTitle: [question.choices objectAtIndex:0] forState:0];
		[questionChoice2Button setTitle: [question.choices objectAtIndex:1] forState:0];
		[questionChoice3Button setTitle: [question.choices objectAtIndex:2] forState:0];
		[questionChoice4Button setTitle: [question.choices objectAtIndex:3] forState:0];
	} else if(currentQuestionIndex < [questionList count]) {
		currentQuestionIndex++;
		[self loadQuestionFromIndex:currentQuestionIndex];
	}
	
	[question release];
	
	
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
