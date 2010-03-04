//
//  question.m
//  QuizMonkey
//
//  Created by Cley on 14/02/10.
//  Copyright 2010 Team Awesome. All rights reserved.
//
#import "Question.h"


@implementation Question

@synthesize type;
@synthesize image;
@synthesize sentence;
@synthesize answers;
@synthesize choices;
@synthesize points;
@synthesize time;


-init {
	
	
	//Set with arbitrarily set limits, no question will ever be this big
	answers = [NSMutableArray arrayWithCapacity: 10];
	choices = [NSMutableArray arrayWithCapacity: 20];
	points = [NSMutableArray arrayWithCapacity: 10];
	
	return self;
}
 
-(NSArray*) validateAnswers: (NSSet*) selected {
	
	//Initialize correct and maxScore
	NSInteger correct = 0;
	NSInteger maxScore = 0;
	
	//Calculate MaxScore by summing up all the elements in the list of scores
	int i = 0;
	for(id point in points) {
		maxScore +=  (NSInteger) [points objectAtIndex: i];
		i++;
	}
	
	//Check whether the answer is in the set of answers
	for(id answer in selected) {
		
		//If it is, add the amount of points associated with that answer to the student's current score
		if([answers containsObject: answer]) {
			correct += (NSInteger) [points objectAtIndex: [answers indexOfObject: answer]];
		}
	}
	
	//Create a score object, simply an array with two values {correct, maxScore}
	NSArray* score = [NSArray arrayWithObjects: @""+correct, @""+maxScore, nil];
	
	//Do not release score because we are returning it	  
	return score;
}

-(void) addAnswer: (NSString*) answer {
	[answers addObject:answer];
}

-(void) addChoice: (NSString*) choice {
	[choices addObject:choice];
}

-(void) addPoint: (NSInteger) point {
	//[points addObject: (id) point];
}


@end
