//
//  QuizMonkeyViewController.m
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 2/15/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "QuizMonkeyViewController.h"

@implementation QuizMonkeyViewController



-(void)touchesBegan: (NSSet *)touches withEvent:(UIEvent *)event {
}
-(void)touchesMoved: (NSSet *)touches withEvent:(UIEvent *)event {
}
-(void)touchesEnded: (NSSet *)touches withEvent:(UIEvent *)event {
	btn_New.center = [[[event allTouches] anyObject] locationInView:self.view];
}

-(IBAction)ShowAlert:(id)sender
{
	//First we set all the parameters of the Alert pop-up
	alr_Alert = [[UIAlertView alloc] initWithTitle:@"You win" message:@"You got 0/10" delegate:nil cancelButtonTitle:@"Continue???" otherButtonTitles:nil];
	//Then we SHOW the alert... simple
	[alr_Alert show];
}
-(void)NewButtonPressed
{
	alr_Alert = [[UIAlertView alloc] initWithTitle:@"Yaaay" message:@"New was pressed" delegate:nil cancelButtonTitle:@"?Continue?" otherButtonTitles:nil];
	[alr_Alert show];
}

-(IBAction)NewButton:(id)sender
{
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
	[self.view addSubview:btn_New];
}

-(IBAction)LoadArray:(id)sender
{
	ThisArray = [NSArray arrayWithObjects: @"Object 1", @"Object 2", @"Object 3", @"Object 4",nil];
	//MUST use retain if you want to use the array in functions outside of this one
	[ThisArray retain];
}
-(IBAction)SetQuestion:(id)sender
{
	//The tag is an integer that you can set as a button property in the xib
	//Same way you were to change the tittle or font of the button
    [lbl_Question setText:[ThisArray objectAtIndex: [sender tag]]];
}

-(IBAction)TapPlay:(id)sender
{
	//Popping up subview
	[self.view addSubview:vew_Question];
}

-(IBAction)TapQuit:(id)sender
{
}

-(IBAction)ExitQuestion:(id)sender
{
	//Removing subview
	[vew_Question removeFromSuperview];
}

-(IBAction)Change_Button:(id)sender
{
	if(btn_Play.currentTitle == @"Play")
		//Change button title code
		[btn_Play setTitle:@"PlayChanged" forState:0];
	else
		//Change button title code
		[btn_Play setTitle:@"Play" forState:0];
}
-(IBAction)Change_Picture:(id)sender
{
	if(img_Monkey.image == [UIImage imageNamed:@"Pic-ProfMonkey.png"])
		//Change prof Monkey's image
		img_Monkey.image = [UIImage imageNamed:@"Pic-Title.png"];
	else
		//Change prof Monkey's image
		img_Monkey.image = [UIImage imageNamed:@"Pic-ProfMonkey.png"];
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


- (void)dealloc {
	[btn_Play release];
	[btn_Quit release];
	[img_Monkey release];
	[vew_Question release];
	[vew_MainView release];
    [super dealloc];
}

@end
