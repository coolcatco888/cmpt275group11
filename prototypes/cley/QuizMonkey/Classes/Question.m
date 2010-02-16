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
@synthesize time;
@synthesize answers;

-init {
	type = @"";
	image = @"";
	time = 0;
	answers = [NSMutableSet new];
	
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
	
	//Create a score object
	NSArray* score = [NSArray arrayWithObjects: @""+correct, @""+maxScore, nil];
	
	//Cleanup temporary sets
	[answerKey release];
	[comparisonSet release];
	
	//Do not release score because we are returning it
					  
	return score;
}

@end
