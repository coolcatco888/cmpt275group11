//
//  Score.h
//  QuizMonkey
//
//  Created by Ariel on 08/03/10.
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


@interface Score : NSObject {
	NSString *studentID;	//Used when getting or submitting high scores
	NSString *password;		//Used when getting or submitting high scores
	NSString *firstName;	//Used when submitting high scores
	NSString *lastName;		//Used when submitting high scores
	NSString *email;		//Used when submitting hgih scores
	
	NSUInteger scoreID;		//Used when getting high scores
	NSUInteger timeLeft;	//Used when getting or submitting high scores
	NSUInteger points;		//Used when getting or submitting high scores
	NSUInteger maxPoints;	//Used when getting or submitting high scores
	NSString *date;			//Used when getting high scores
	
	//counters for reward system. Statistical analysis users' correct anwswer
	//The following variables are used when submitting high scores
	NSUInteger combo;
	NSUInteger maxCombo;
	NSUInteger fillInTheBlank;
	NSUInteger pickOutWords;
	NSUInteger findTheMisspelledWord;
	NSUInteger matchThePic;
	NSUInteger findVerb;
	NSUInteger findNoun;
	NSUInteger findAdj;
	NSUInteger grammar;
	NSUInteger vocabulary;
	
}

@property (assign) NSString *studentID;
@property (assign) NSString *firstName;
@property (assign) NSString *lastName;
@property (assign) NSString *email;
@property (assign) NSString *password;
@property (assign) NSUInteger scoreID;
@property (assign) NSUInteger timeLeft;
@property (assign) NSUInteger points;
@property (assign) NSUInteger maxPoints;
@property (assign) NSString *date;
@property (assign) NSUInteger combo;
@property (assign) NSUInteger maxCombo;
@property (assign) NSUInteger fillInTheBlank;
@property (assign) NSUInteger pickOutWords;
@property (assign) NSUInteger findTheMisspelledWord;
@property (assign) NSUInteger matchThePic;
@property (assign) NSUInteger findVerb;
@property (assign) NSUInteger findNoun;
@property (assign) NSUInteger findAdj;
@property (assign) NSUInteger grammar;
@property (assign) NSUInteger vocabulary;

-(void)updateCounters:(NSString*)questionType;
@end
