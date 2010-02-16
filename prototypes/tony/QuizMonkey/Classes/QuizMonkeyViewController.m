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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
}
 */
-(void)renew
{
	current_question=[question_array objectAtIndex:num];
	if ([current_question.type compare: @"Pick Out Words"]==NSOrderedSame)
	{
		//change view
		//......
		
		//set this view
		PickOutWordsQuestion* new_question=[question_array objectAtIndex:num];
		question_label.text=[[NSString alloc]initWithFormat:@"Question %d: %@ ",num+1,new_question.question];
		
		
		
		[ans1 setTitle: @"a"forState: UIControlStateNormal];
		[ans2 setTitle: @"b"forState: UIControlStateNormal];
		[ans3 setTitle: @"c"forState: UIControlStateNormal];
		[ans4 setTitle: @"d"forState: UIControlStateNormal];
		result.text=@" ";
		//.......
		
	}
	else
	{
		//.....
	}
	num++;
	
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	total=5;
	num=0;
	question_array=[NSMutableArray arrayWithCapacity:total];
	//PickOutWordsQuestion* current_question=[PickOutWordsQuestion new];
	
	for (NSInteger i=0; i<total; i++) {
		//do xml phase here
		PickOutWordsQuestion* temp=[PickOutWordsQuestion new];
		temp.answer=@"a";
		temp.question=@"C_t";
		temp.image=@"cat.png";
		
		[question_array addObject:temp];
		
	}
	//.......
	
	
	[self renew];
	
	
}



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

-(IBAction)PushButton:(id)sender
{
	NSString* user_answer=[sender titleForState:UIControlStateNormal];
	NSString* user_answer_withFormat=[[NSString alloc]initWithFormat:@"%@",user_answer];
	if([current_question validateAnswer : user_answer_withFormat])
	{
		[result setTextColor:[UIColor greenColor]];
		result.text=@"Correct!!!";
	}
	else
	{
		[result setTextColor:[UIColor redColor]];
		result.text=@"Wrong!!!";
	}
	[user_answer release];
	[user_answer_withFormat release];
	
	
	
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	//[current_question release];
	[question_array release];
	
    [super dealloc];
}

@end
