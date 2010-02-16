//
//  Question.m
//  QuizMonkey
//
//  Created by yang qiong on 2/13/10.
//  Copyright 2010 sfu. All rights reserved.
//

#import "Question.h"


@implementation Question
@synthesize image;
@synthesize type;
@synthesize time;
-init
{
	image=@"N/A";
	type=@"N/A";
	time=0;
	
	return self;
}
-(bool)validateAnswer:(NSString*)user_answer
{
	return YES;
}

@end
