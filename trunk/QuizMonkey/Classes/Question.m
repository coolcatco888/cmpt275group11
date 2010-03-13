#import "Question.h"

@implementation Question

@synthesize type;
@synthesize image;
@synthesize sentence;
@synthesize choices;
@synthesize points;
@synthesize time;


-init{
	choices = [NSMutableArray arrayWithCapacity:20];
	points = [NSMutableArray arrayWithCapacity:20];
	return self;
}

-(void) addChoice: (NSString*) newChoice {
	[choices addObject:newChoice];
}

-(void) addPoint: (NSInteger) newPoint {
	[points addObject:[NSNumber numberWithInteger:newPoint]];
}

@end