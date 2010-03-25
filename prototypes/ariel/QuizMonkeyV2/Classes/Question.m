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
	//Sets up the two arrays that the question object uses
	choices = [NSMutableArray arrayWithCapacity:20];
	points = [NSMutableArray arrayWithCapacity:20];
	//Then retains them both
	[choices retain];
	[points retain];
	return self;
}

-(void) addChoice: (NSString*) newChoice {
	//Adding a new object you the choices array
	[choices addObject:newChoice];
}

-(void) addPoint: (NSInteger) newPoint {
	//Adding a new object to the points array
	[points addObject:[NSNumber numberWithInteger:newPoint]];
}

@end