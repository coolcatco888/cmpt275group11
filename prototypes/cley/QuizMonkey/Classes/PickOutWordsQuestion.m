//
//  PickOutWordsQuestion.m
//  QuizMonkey
//
//  Created by yang qiong on 2/14/10.
//  Copyright 2010 sfu. All rights reserved.
//

#import "PickOutWordsQuestion.h"


@implementation PickOutWordsQuestion
@synthesize question;
@synthesize options;
@synthesize answer;
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
	type=@"Pick Out Words";
	//.........
	return self;
}


@end
