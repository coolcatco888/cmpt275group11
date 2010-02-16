//
//  FillinBlankQuestion.m
//  QuizMonkey
//
//  Created by yang qiong on 2/14/10.
//  Copyright 2010 sfu. All rights reserved.
//

#import "FillinBlankQuestion.h"



@implementation FillinBlankQuestion

@synthesize answer;
@synthesize sentence;

-(bool)validateAnswer:(NSString*)user_answer
{
	if([answer compare:user_answer]==NSOrderedSame)
	{
		return YES;
	}
	else
	{
		return NO;
	}
}
-init
{
	[super init];
	type=@"Fill in Blank";
	//.........
	return self;
}

@end
