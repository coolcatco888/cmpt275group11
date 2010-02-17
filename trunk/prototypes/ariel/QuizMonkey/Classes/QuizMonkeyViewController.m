//
//  QuizMonkeyViewController.m
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 2/15/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "QuizMonkeyViewController.h"

@implementation QuizMonkeyViewController

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
