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
	NSString* sentence;//This is for FillInTheBlank Questions
	NSMutableArray* answers;//The set containing correct answers, some questions will require the student to pick out the verbs
	NSMutableArray* choices;//The set containing the options available for the student to choose
	NSMutableArray* points;//The set containing the points associated with each answer, the number should match the number of answers
	int time;//How much time is allotted for this type of question

}

@property (assign) NSString* type;
@property (assign) NSString* image;
@property (assign) NSString* sentence;
@property (assign) NSMutableArray* answers;
@property (assign) NSMutableArray* choices;
@property (assign) NSMutableArray* points;
@property (assign) int time;



-(NSArray*) validateAnswers: (NSSet*) answers;
-(void) setType: (NSString*) newType;
-(void) setImage: (NSString*) newImage;
-(void) setSentence: (NSString*) newSentence;
-(void) setAnswers: (NSMutableArray*) answers;
-(void) setChoices: (NSMutableArray*) choices;
-(void) setPoints: (NSMutableArray*) points;
-(void) addAnswer: (NSString*) answer;
-(void) addChoice: (NSString*) choice;
-(void) addPoint: (NSInteger) point;

@end
