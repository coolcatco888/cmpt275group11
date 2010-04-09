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

-(void)updateCounters:(NSString*)questionType
{
	combo++;
	if (combo>maxCombo)
	{
		maxCombo=combo;
	}
	
	if ([questionType isEqualToString:@"Fill in the blank"]) 
	{
		fillInTheBlank++;
		vocabulary++;
		
	} 
	else if ([questionType isEqualToString:@"Pick out the words"])
	{
		pickOutWords++;
		vocabulary++;
	}
	else if ([questionType isEqualToString:@"Find the misspelled word"])
	{
		findTheMisspelledWord++;
		vocabulary++;
	}
	else if ([questionType isEqualToString:@"Match the picture"])
	{
		matchThePic++;
		vocabulary++;
	}
	else if ([questionType isEqualToString:@"Find the nouns"])
	{
		findNoun++;
		grammar++;
	}
	else if ([questionType isEqualToString:@"Find the adjectives"])
	{
		findAdj++;
		grammar++;
	}
	else if ([questionType isEqualToString:@"Find the verbs"])
	{
		findVerb++;
		grammar++;
	}
}
@end
