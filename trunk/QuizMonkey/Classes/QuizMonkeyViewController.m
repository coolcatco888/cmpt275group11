//
//  QuizMonkeyViewController.m
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 2/15/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "Question.h"
#import "ClassQuestionParser.h"
#import "QuizMonkeyViewController.h"

@implementation QuizMonkeyViewController


////////////////////////Main View Functions
-(IBAction)ShowHighScoresView:(id)sender {
	[vew_MainMenu addSubview:vew_HighScores];
}
-(IBAction)ShowQuestionView:(id)sender {
	ClassQuestionParser *Quiz = [ClassQuestionParser new];
	QuestionList = [Quiz loadQuestionsFromXML:@"Questions"];
	[vew_MainMenu addSubview:vew_Question];
	
	SEL selector = @selector(selectChoice:);
	[self createButton:@"WTF" :0 :0 :200 :100 :selector];
	[Quiz retain];
}
-(IBAction)ShowAlert:(id)sender {
	//First we set all the parameters of the Alert pop-up
	alr_Alert = [[UIAlertView alloc] initWithTitle:@"You win" message:@"You got 0/10" delegate:nil cancelButtonTitle:@"Continue???" otherButtonTitles:nil];
	//Then we SHOW the alert... simple
	[alr_Alert show];
}


////////////////////////Question View Functions
-(void) createButton:(NSString*) title :(int) x :(int) y :(int) width :(int) height :(SEL) buttonActionFunction {
	//Must create a button object
	IBOutlet UIButton* newButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	//Just setong the frame (x,y,Width,Height)
	newButton.frame = CGRectMake(x,y,width,height);
	
	//Set the Title of the button, MUST NOT FORGET "forState"
	[newButton setTitle:title forState:UIControlStateNormal];
	
	//Setting which function will be called when button pressed
	//buttonActionFunction is a SEL or selector type which is a pointer to an instance method
	[newButton addTarget:self action:buttonActionFunction forControlEvents:UIControlEventTouchUpInside];
	
	//Then add the button to the current view as a subview
	[vew_Question addSubview:newButton];
	[newButton retain];	
}

-(void) selectChoice:(id)sender {
	[(UIButton*)sender removeFromSuperview];
	
}

-(IBAction)ExitQuestionView:(id)sender {
	//Removing subview
	[vew_Question removeFromSuperview];
}
-(IBAction)LoadObjectQuestion:(id)sender{
	
}


////////////////////////High Scores View Functions
-(IBAction)ExitHighScoresView:(id)sender {
	[vew_HighScores removeFromSuperview];
}


-(IBAction)SetCell:(id)sender {
/*	cel_Score1 = [tbl_HighScores dequeueReusableCellWithIdentifier:@"Score1"];
	if(cel_Score1==nil)
		cel_Score1 = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"Score1"] autorelease];
	[cel_Score1 setText:@"Super!!!"];*/
}


 



-(void)touchesBegan: (NSSet *)touches withEvent:(UIEvent *)event {
	TapLocation = [[[event allTouches] anyObject] locationInView:vew_MainMenu];
}
-(void)touchesMoved: (NSSet *)touches withEvent:(UIEvent *)event {
	CGPoint TapLocationNew = [[[event allTouches] anyObject] locationInView:vew_MainMenu];
	
	//Applying the displacement to the center of the screen, moving it up and down
	vew_HighScores.center = CGPointMake(vew_HighScores.center.x , vew_HighScores.center.y - (TapLocation.y - TapLocationNew.y));
	
	//Seting the boundaries so the high scores can't go off the screen
	if(vew_HighScores.center.y > 300)
		vew_HighScores.center = CGPointMake(vew_HighScores.center.x , 300);
	if(vew_HighScores.center.y < 0)
		vew_HighScores.center = CGPointMake(vew_HighScores.center.x , 0);
	
	//Updating the user's tap location
	TapLocation = TapLocationNew;
	
	//NSLog(@"Y: %f", TapLocationNew.y);

}
-(void)touchesEnded: (NSSet *)touches withEvent:(UIEvent *)event {
	TapLocation = [[[event allTouches] anyObject] locationInView:vew_MainMenu];
	btn_New.center = [[[event allTouches] anyObject] locationInView:vew_MainMenu];
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
	[vew_MainMenu release];
	[vew_Question release];
	[vew_HighScores release];
	[btn_Play release];
	[btn_Quit release];
	[btn_New release];
	[img_Monkey release];
	[lbl_Question release];
	[lbl_New release];
	[alr_Alert release];
	[ThisArray release];
    [super dealloc];
}

@end
