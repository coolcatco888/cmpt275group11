//
//  ObjectQuestion.h
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 2/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ObjectQuestion : NSObject {
	NSString *Type;
	NSString *pic_Name;
	NSString *Sentence;
	NSMutableArray *Choices_Words;
	NSMutableArray *Choices_Points;
	NSInteger Time;
}

@property (assign) NSString* Type;
@property (assign) NSString* pic_Name;
@property (assign) NSString* Sentence;
@property (assign) NSMutableArray* Choices_Words;
@property (assign) NSMutableArray* Choices_Points;
@property (assign) NSInteger Time;

-(void) addChoices_Words: (NSString*) newChoice;
-(void) addChoices_Points: (NSInteger) newPoint;

@end

