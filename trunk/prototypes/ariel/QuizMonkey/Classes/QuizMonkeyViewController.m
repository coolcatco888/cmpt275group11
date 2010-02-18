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

-(IBAction)NewButton:(id)sender
{
/*	lbl_New = [[UILabel alloc] init];

	CGPoint PointXYZ;
	PointXYZ.x = 200;
	PointXYZ.y = 150;
	lbl_New.center = PointXYZ;

 [lbl_New setText:@"Something"];
 [self.view addSubview:lbl_New];
 [lbl_New retain];
 */	

	
	
	btn_New = [[UIButton alloc] init];
	//[btn_New setTitle:@"New Button" forState:0];
	[btn_New setImage:[UIImage imageNamed:@"Pic-Title.png"] forState:0];

	CGPoint PointXY;
	PointXY.x = 200;
	PointXY.y = 150;
	btn_New.center = PointXY;

	[self.view addSubview:btn_New];
	[btn_New retain];

	//NSLog(btn_Play);
	//NSLog(btn_New);

}

-(IBAction)LoadArray:(id)sender
{
	ThisArray = [NSArray arrayWithObjects: @"Object 1", @"Object 2", @"Object 3", @"Object 4",nil];
	[ThisArray retain];
	//[lbl_Question setText:[ThisArray objectAtIndex: 0]];
}
-(IBAction)SetQuestion:(id)sender
{
	//ThisArray = [NSArray arrayWithObjects: @"Object 1", @"Object 2", @"Object 3", @"Object 4",nil];
	//btn_Play setTitle: [ThisArray objectAtIndex:0] forState:0];
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
