//
//  Question.h
//  QuizMonkey
//
//  Created by yang qiong on 2/13/10.
//  Copyright 2010 sfu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Question : NSObject {
	NSString* type;
	NSString* image;
	int time;

}
-(bool)validateAnswer:(NSString*)user_answer;
@property (retain,nonatomic)NSString* type;
@property (retain,nonatomic)NSString* image;
@property int time;

@end
