//
//  FillinBlankQuestion.h
//  QuizMonkey
//
//  Created by yang qiong on 2/14/10.
//  Copyright 2010 sfu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"

@interface FillinBlankQuestion : Question {
	NSString* sentence;
	NSString* answer;
	

}
@property (retain,nonatomic)NSString* sentence;
@property (retain,nonatomic)NSString* answer;



@end
