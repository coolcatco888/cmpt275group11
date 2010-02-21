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
@synthesize answers;
@synthesize choices;
@synthesize time;


-init {
	type = @"";
	image = @"";
	time = 0;
	
	//Set with arbitrarily set limits, no question will ever be this big
	answers = [NSMutableSet setWithCapacity: 10];
	choices = [NSMutableSet setWithCapacity: 20];
	
	return self;
}
 
-(NSArray*) validateAnswers: (NSSet*) selected {
	
	
	//Fill answer key with question answers
	NSSet* answerKey = [NSSet new];
	[answers setSet: answerKey];
	
	NSInteger correct = [answerKey count];
	NSInteger maxScore = correct;
	
	//Fill comparison set with user selected answers
	NSMutableSet* comparisonSet = [NSMutableSet setWithSet:answerKey];
	[comparisonSet minusSet: selected];
	
	//Subtract the answer key from the comparison set and see
	//if there is any difference
	correct -= [comparisonSet count];
	
	//Create a score object, simply an array with two values {correct, maxScore}
	NSArray* score = [NSArray arrayWithObjects: @""+correct, @""+maxScore, nil];
	
	//Cleanup temporary sets
	[answerKey release];
	[comparisonSet release];
	
	//Do not release score because we are returning it	  
	return score;
}

-(void) addAnswer: (NSString*) answer {
	[answers addObject:answer];
}

-(void) addChoice: (NSString*) choice {
	[choices addObject:choice];
}

@end
