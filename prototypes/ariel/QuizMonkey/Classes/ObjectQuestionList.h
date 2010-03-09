//
//  ObjectQuestionList.h
//  QuizMonkey
//
//  Created by Ariel on 08/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ObjectQuestionList : NSObject {
	NSMutableArray *Questions;
}

@end

@implementation ObjectQuestionList

-(ObjectQuestion *)getQuestion:(NSUInteger)QuestionIndex{
	return [Questions objectAtIndex:QuestionIndex];
}
-(void)addQuestion:(ObjectQuestion *)NewQuestion{
	[Questions addObject:NewQuestion];
}

@end
