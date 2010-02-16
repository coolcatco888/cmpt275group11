//
//  QuizMonkeyViewController.m
//  QuizMonkey
//
//  Created by yang qiong on 2/13/10.
//  Copyright sfu 2010. All rights reserved.
//

#import "QuizMonkeyViewController.h"

@implementation QuizMonkeyViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	q1=[PickOutWordsQuestion new];
	q1.answer=@"a";
	q1.question=@"c_t";
	q1.image=@"cat.png";
	//.......
	
	[self renew];
	
}
-(void)renew
{
	question_label.text=q1.question;
	//.......
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
	[q1 release];
    [super dealloc];
}

@end
