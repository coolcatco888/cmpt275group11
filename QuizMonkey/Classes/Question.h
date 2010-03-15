//
//  Question.h
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 2/17/10.
//
//  Worked on by Cley, Ariel, Tony, Meiko, Daniel
//
//  Known Bugs: none
//
//  Changes:
//   - 1.0 - Implemented
//
//  Copyright 2010 Team Awesome. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Question : NSObject {
	NSString *type;//Contais the type of the question
	NSString *image;//Contais the filename of the image (image must be in the project folder)
	NSString *sentence;//Contains the question sentence (the question being asked to the user)
	NSMutableArray *choices;//An array of the different choices that the user has
	NSMutableArray *points;//An array of the different points that each choice gives the user
	NSInteger time;//Contains the maximum amount of time that the question gives
}

@property (assign) NSString* type;
@property (assign) NSString* image;
@property (assign) NSString* sentence;
@property (assign) NSMutableArray* choices;
@property (assign) NSMutableArray* points;
@property (assign) NSInteger time;

-(void) addChoice: (NSString*) newChoice;//Adds a new choice to the choices array
-(void) addPoint: (NSInteger) newPoint;//Adds a new point to the points array

@end

