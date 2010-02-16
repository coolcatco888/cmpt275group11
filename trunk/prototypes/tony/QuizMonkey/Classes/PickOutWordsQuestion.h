//
//  PickOutWordsQuestion.h
//  QuizMonkey
//
//  Created by yang qiong on 2/14/10.
//  Copyright 2010 sfu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"

@interface PickOutWordsQuestion : Question {
	NSString* question;
	NSString* answer;
	NSString* options;
	
}
@property (retain,nonatomic)NSString* question;
@property (retain,nonatomic)NSString* answer;
@property (retain,nonatomic)NSString* options;



@end
