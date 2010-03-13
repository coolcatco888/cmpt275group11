//
//  ObjectQuestion.h
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 2/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Question : NSObject {
	NSString *type;
	NSString *image;
	NSString *sentence;
	NSMutableArray *choices;
	NSMutableArray *points;
	NSInteger time;
}

@property (assign) NSString* type;
@property (assign) NSString* image;
@property (assign) NSString* sentence;
@property (assign) NSMutableArray* choices;
@property (assign) NSMutableArray* points;
@property (assign) NSInteger time;

-(void) addChoice: (NSString*) newChoice;
-(void) addPoint: (NSInteger) newPoint;

@end

