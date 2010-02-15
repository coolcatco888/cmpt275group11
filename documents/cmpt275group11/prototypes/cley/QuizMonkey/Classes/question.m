//
//  question.m
//  QuizMonkey
//
//  Created by Cley on 14/02/10.
//  Copyright 2010 Team Awesome. All rights reserved.
//
#import "question.h"


@implementation question

@synthesize type;
@synthesize image;
@synthesize time;

-init {
	type = @"";
	image = @"";
	time = 0;
	
	return self;
}
 
-(BOOL) validateAnswers: (int*) answers {
	return FALSE;
}

@end
