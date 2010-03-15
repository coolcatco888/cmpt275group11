//
//  Question.m
//  QuizMonkey
//
//  Created by Cley Tang on 3/12/10.
//
//  Worked on by Cley, Ariel, Tony, Meiko, Daniel
//
//  Known Bugs: See the header file
//
//  Changes: See the header file
//
//  Copyright 2010 Team Awesome. All rights reserved.
//

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
	[choices retain];
}

-(void) addPoint: (NSInteger) newPoint {
	[points addObject:[NSNumber numberWithInteger:newPoint]];
	[points retain];
}

@end