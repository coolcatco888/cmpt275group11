//
//  question.h
//  QuizMonkey
//
//  Created by Cley on 14/02/10.
//  Copyright 2010 Team Awesome. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Question : NSObject {
	NSString* type;
	NSString* image;
	NSMutableSet* answers;
	int time;

}

@property (assign) NSString* type;
@property (assign) NSString* image;
@property (assign) int time;
@property (assign) NSMutableSet* answers;


-(NSArray*) validateAnswers: (NSSet*) answers;
-(void) setType: (NSString*) newType;
-(void) setImage: (NSString*) newImage;
-(void) setAnswers: (NSMutableSet*) answers;

@end
