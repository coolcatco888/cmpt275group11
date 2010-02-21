//
//  question.h
//  QuizMonkey
//
//  Created by Cley on 14/02/10.
//  Copyright 2010 Team Awesome. All rights reserved.
//

#import <Foundation/Foundation.h>

//TODO: Maybe we can just have one question object?
@interface Question : NSObject {
	NSString* type;//Specifies the type of question, FillinTheBlank or PickOutWords Question
	NSString* image;//URL of the image that is to be displayed
	NSMutableSet* answers;//The set containing correct answers, some questions will require the student to pick out the verbs
	NSMutableSet* choices;//The set containing the options available for the student to choose
	int time;//How much time is allotted for this type of question

}

@property (assign) NSString* type;
@property (assign) NSString* image;
@property (assign) NSMutableSet* answers;
@property (assign) NSMutableSet* choices;
@property (assign) int time;



-(NSArray*) validateAnswers: (NSSet*) answers;
-(void) setType: (NSString*) newType;
-(void) setImage: (NSString*) newImage;
-(void) setAnswers: (NSMutableSet*) answers;
-(void) setChoices: (NSMutableSet*) choices;
-(void) addAnswer: (NSString*) answer;
-(void) addChoice: (NSString*) choice;

@end
