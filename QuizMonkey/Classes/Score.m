//
//  Score.m
//  QuizMonkey
//
//  Created by Ariel on 08/03/10.
//
//  Worked on by Cley, Ariel, Tony, Meiko, Daniel
//
//  Known Bugs: See the header file
//
//  Changes: See the header file
//
//  Copyright 2010 Team Awesome. All rights reserved.
//

#import "Score.h"


@implementation Score

@synthesize studentID;
@synthesize firstName;
@synthesize lastName;
@synthesize email;
@synthesize password;
@synthesize scoreID;
@synthesize timeLeft;
@synthesize points;
@synthesize maxPoints;
@synthesize date;
@synthesize combo;
@synthesize maxCombo;
@synthesize fillInTheBlank;
@synthesize pickOutWords;
@synthesize findTheMisspelledWord;
@synthesize matchThePic;
@synthesize findVerb;
@synthesize findNoun;
@synthesize findAdj;
@synthesize grammar;
@synthesize vocabulary;
@synthesize reward0;
@synthesize reward1;
@synthesize reward2;
@synthesize reward3;
@synthesize reward4;
@synthesize reward5;

- init
{
	reward0=FALSE;
	reward1=FALSE;
	reward2=FALSE;
	reward3=FALSE;
	reward4=FALSE;
	reward5=FALSE;
	
	return self;
}

-(void)updateCounters:(NSString*)questionType//this function is to update counters data for rewards system
{
	combo++;
	if (combo>maxCombo)			//if the combo is greater than max combo, then update max combo
	{
		maxCombo=combo;
	}
	
	if ([questionType isEqualToString:@"Fill in the blank"]) //if the question type is fill in the blank, then update fillInTheBlank and vocabulary counters
	{
		fillInTheBlank++;
		vocabulary++;
		
	} 
	else if ([questionType isEqualToString:@"Pick out the words"])//if the question type is pick out words, then update pickOutWords and vocabulary counters
	{
		pickOutWords++;
		vocabulary++;
	}
	else if ([questionType isEqualToString:@"Find the misspelled word"])//if the question type is find the misspelled word, then update findTheMisspelledWord and vocabulary counters
	{
		findTheMisspelledWord++;
		vocabulary++;
	}
	else if ([questionType isEqualToString:@"Match the picture"])//if the question type is match the picture, then update matchThePic and vocabulary counters
	{
		matchThePic++;
		vocabulary++;
	}
	else if ([questionType isEqualToString:@"Find the nouns"])//if the question type is find the nouns, then update findNoun and grammar counters
	{
		findNoun++;
		grammar++;
	}
	else if ([questionType isEqualToString:@"Find the adjectives"])//if the question type is find the adjectives, then update findAdj and grammarcounters
	{
		findAdj++;
		grammar++;
	}
	else if ([questionType isEqualToString:@"Find the verbs"])//if the question type is find the verbs, then update findVerb and vocabulary counters
	{
		findVerb++;
		grammar++;
	}
}
@end
