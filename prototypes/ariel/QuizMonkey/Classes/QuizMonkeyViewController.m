//
//  QuizMonkeyViewController.m
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 2/15/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "ObjectQuestion.h"
#import "ObjectQuestionList.h"
#import "ClassQuestionParser.h"
#import "QuizMonkeyViewController.h"

@implementation QuizMonkeyViewController


////////////////////////Main View Functions
-(IBAction)ShowHighScoresView:(id)sender {
	[vew_MainMenu addSubview:vew_HighScores];
}
-(IBAction)ShowQuestionView:(id)sender {
	ClassQuestionParser *Quiz = [ClassQuestionParser new];
	//ObjectQuestionList *Questions = [ObjectQuestionList new];
	//Questions = [ObjectQuestionList new];
	QuestionList = [Quiz LoadXMLQuestions:@"Questions"];
	ObjectQuestion *TMP_Question = [QuestionList getQuestion:0];
	[lbl_Type setText:[TMP_Question Type]];
	[lbl_pic_Name setText:[TMP_Question pic_Name]];
	[lbl_Sentence setText:[TMP_Question Sentence]];
	[lbl_Choice1_Word setText:[[TMP_Question Choices_Words] objectAtIndex:0]];
	[lbl_Choice2_Word setText:[[TMP_Question Choices_Words] objectAtIndex:1]];
	[lbl_Choice3_Word setText:[[TMP_Question Choices_Words] objectAtIndex:2]];
	[lbl_Choice4_Word setText:[[TMP_Question Choices_Words] objectAtIndex:3]];
	//NSLog(@"%@",[[TMP_Question Choices_Points] objectAtIndex:0]);
	[lbl_Choice1_Points setText:[[[TMP_Question Choices_Points] objectAtIndex:0] stringValue]];
	[lbl_Choice2_Points setText:[[[TMP_Question Choices_Points] objectAtIndex:1] stringValue]];
	//[lbl_Choice1_Points setText:[[[TMP_Question Choices_Points] objectAtIndex:2] stringValue]];
	//[lbl_Choice1_Points setText:[[[TMP_Question Choices_Points] objectAtIndex:3] stringValue]];
	//[lbl_Choice1_Points setText:[[[TMP_Question Choices_Points] objectAtIndex:4] stringValue]];
	//[lbl_Choice2_Points setText:[[[QuestionList getQuestion:0] Choices_Points] objectAtIndex:1]];
	//[lbl_Choice3_Points setText:[[[QuestionList getQuestion:0] Choices_Points] objectAtIndex:2]];
	//[lbl_Choice4_Points setText:[[[QuestionList getQuestion:0] Choices_Points] objectAtIndex:3]];
	[lbl_Time setText:@""+[TMP_Question Time]];
	//[Questions retain];
	[vew_MainMenu addSubview:vew_Question];
	//NSLog(@"%@",[[Quiz2 getQuestion:0] Type]);
	//NSLog(@"Hello");
	//[lbl_Type setText:[[Quiz2 getQuestion:0] Type]];
	[Quiz retain];
}
-(IBAction)ShowAlert:(id)sender {
	//First we set all the parameters of the Alert pop-up
	alr_Alert = [[UIAlertView alloc] initWithTitle:@"You win" message:@"You got 0/10" delegate:nil cancelButtonTitle:@"Continue???" otherButtonTitles:nil];
	//Then we SHOW the alert... simple
	[alr_Alert show];
}
-(IBAction)Change_Button:(id)sender {
	if(btn_Play.currentTitle == @"Play")
		//Change button title code
		[btn_Play setTitle:@"PlayChanged" forState:0];
	else
		//Change button title code
		[btn_Play setTitle:@"Play" forState:0];
}
-(IBAction)Change_Picture:(id)sender {
	if(img_Monkey.image == [UIImage imageNamed:@"Pic-ProfMonkey.png"])
		//Change prof Monkey's image
		img_Monkey.image = [UIImage imageNamed:@"Pic-Title.png"];
	else
		//Change prof Monkey's image
		img_Monkey.image = [UIImage imageNamed:@"Pic-ProfMonkey.png"];
}
-(IBAction)NewButton:(id)sender {
	//Must create a button object
	btn_New = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	//Just setong the frame (x,y,Width,Height)
	btn_New.frame = CGRectMake(100,170,100,30);
	
	//Set the Title of the button, MUST NOT FORGET "forState"
	[btn_New setTitle:@"New" forState:UIControlStateNormal];
	
	//Setting which function will be called when button pressed
	//addTarget is not really needed and I don't know what @selector is for
	[btn_New addTarget:self action:@selector(NewButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	
	//Then add the button to the current view as a subview
	[vew_MainMenu addSubview:btn_New];
	[btn_New retain];
}
-(void)NewButtonPressed {
	alr_Alert = [[UIAlertView alloc] initWithTitle:@"Yaaay" message:@"New was pressed" delegate:nil cancelButtonTitle:@"?Continue?" otherButtonTitles:nil];
	[alr_Alert show];
}

////////////////////////Question View Functions
-(IBAction)ExitQuestionView:(id)sender {
	//Removing subview
	[vew_Question removeFromSuperview];
}
-(IBAction)LoadObjectQuestion:(id)sender{
	
}
-(IBAction)LoadArray:(id)sender {
	ThisArray = [NSArray arrayWithObjects: @"Object 1", @"Object 2", @"Object 3", @"Object 4",nil];
	//MUST use retain if you want to use the array in functions outside of this one
	[ThisArray retain];
}
-(IBAction)SetQuestion:(id)sender {
	//The tag is an integer that you can set as a button property in the xib
	//Same way you were to change the tittle or font of the button
    [lbl_Question setText:[ThisArray objectAtIndex: [sender tag]]];
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

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


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
