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
	NSUInteger combo;					//Used to count current correct answers in a row
	NSUInteger maxCombo;				//Used to store the max correct answers in a row in this quiz
	NSUInteger fillInTheBlank;			//Used to count how many fill in the blank questions the user got correctly
	NSUInteger pickOutWords;			//Used to count how many pick out words questions the user got correctly
	NSUInteger findTheMisspelledWord;	//Used to count how many find the misspelled word questions the user got correctly
	NSUInteger matchThePic;				//Used to count how many match the picture questions the user got correctly
	NSUInteger findVerb;				//Used to count how many find the verbs questions the user got correctly
	NSUInteger findNoun;				//Used to count how many find the nouns questions the user got correctly
	NSUInteger findAdj;					//Used to count how many find the adjectives questions the user got correctly
	NSUInteger grammar;					//Used to count how many grammar questions(find the verbs,nouns,adjs) the user got correctly
	NSUInteger vocabulary;				//Used to count how many vocabulary questions(fill in the blank,pick out words,match the picture, find the misspelled word) the user got correctly
	bool reward0;						//Used to judge user achieve the top student reward or not
	bool reward1;						//Used to judge user achieve the pass reward or not
	bool reward2;						//Used to judge user achieve the combo5 reward or not
	bool reward3;						//Used to judge user achieve the grammar reward or not
	bool reward4;						//Used to judge user achieve the vocabulary reward or not
	bool reward5;						//Used to judge user achieve the speed reward or not
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

@property (assign) bool reward0;
@property (assign) bool reward1;
@property (assign) bool reward2;
@property (assign) bool reward3;
@property (assign) bool reward4;
@property (assign) bool reward5;

-(void)updateCounters:(NSString*)questionType;	//this function is to update counters data for rewards system
@end
