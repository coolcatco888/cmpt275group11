//
//  Score.h
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 3/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Score : NSObject {
	NSString *studentID;
	NSString *firstName;
	NSString *lastName;
	NSString *email;
	NSString *password;

	NSUInteger scoreID;
	NSUInteger timeLeft;
	NSUInteger points;
	NSUInteger maxPoints;
	NSDate *date;
	
	//counters for reward system. Statistical analysis users' correct anwswer
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
@property (assign) NSDate *date;
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
