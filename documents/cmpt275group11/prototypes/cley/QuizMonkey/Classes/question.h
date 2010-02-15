//
//  question.h
//  QuizMonkey
//
//  Created by Cley on 14/02/10.
//  Copyright 2010 Team Awesome. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface question : NSObject {
	NSString* type;
	NSString* image;
	int time;

}

@property (assign) NSString* type;
@property (assign) NSString* image;
@property (assign) int time;


-(BOOL) validateAnswers: (int*) answers;
-(void) setType: (NSString*) newType;
-(void) setImage: (NSString*) newImage;

@end