//
//  ObjectQuestion.h
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 2/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ObjectQuestion : NSObject {
	NSInteger Type;
	NSString *Question;
	NSString *pic_Path;
	NSInteger pic_X;
	NSInteger pic_Y;
	NSInteger pic_W;
	NSInteger pic_H;
	NSInteger Score_Max;
	NSInteger Score_Current;
	NSArray *Choices_Words;
	NSSet *Choices_Score;
}

@end
