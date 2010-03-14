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
	questionChoiceButtons = [NSArray arrayWithObjects: questionChoice1Button, questionChoice2Button, questionChoice3Button, questionChoice4Button, nil]; 
	manager = [[QuestionViewManager alloc] initQuestionViewManager:mainMenuView 
																  :questionView 
																  :questionSentenceLabel 
																  :questionSentenceBottomLabel 
																  :questionTypeLabel 
																  :questionImage 
																  :questionChoiceButtons];
	
}
-(IBAction)ShowAlert:(id)sender {

}


////////////////////////Question View Functions
-(IBAction) selectChoice:(id)sender {
	[manager selectChoice:sender];
}

-(IBAction)exitQuestionView:(id)sender {
	//Removing subview
	[questionView removeFromSuperview];
}

-(IBAction)nextQuestion:(id)sender {
	[manager nextQuestion:sender];	
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
    [super dealloc];
}

@end
