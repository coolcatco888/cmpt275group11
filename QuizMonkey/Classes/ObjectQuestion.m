#import "ObjectQuestion.h"

@implementation ObjectQuestion

@synthesize Type;
@synthesize pic_Name;
@synthesize Sentence;
@synthesize Choices_Words;
@synthesize Choices_Points;
@synthesize Time;

-init{
	Choices_Words = [NSMutableArray arrayWithCapacity:20];
	Choices_Points = [NSMutableArray arrayWithCapacity:20];
	return self;
}

-(void) addChoices_Words: (NSString*) newChoice {
	[Choices_Words addObject:newChoice];
}

-(void) addChoices_Points: (NSInteger) newPoint {
	[Choices_Points addObject:[NSNumber numberWithInteger:newPoint]];
}

@end