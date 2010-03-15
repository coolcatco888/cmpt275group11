//
//  QuizMonkeyTestCase.m
//  QuizMonkey
//
//  Created by Tony Yang on 3/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QuizMonkeyTestCase.h"

@implementation QuizMonkeyTestCase

- (void)testTestFramework {
	NSMutableString* testXML = [NSMutableString stringWithCapacity:9000];
	[testXML appendString:@"<questions>"];
	
	[testXML appendString:@"<question>"];
	[testXML appendString:@"<type>Fill in the blank</type>"];
	[testXML appendString:@"<image></image>"];
	[testXML appendString:@"<sentence>It smacked my face all of a su_den.</sentence>"];
	[testXML appendString:@"<choice>h</choice><choice>p</choice><choice>d</choice><choice>x</choice>"];
	[testXML appendString:@"<point>0</point><point>0</point><point>10</point><point>0</point>"];
	[testXML appendString:@"<time>5</time>"];
	[testXML appendString:@"</question>"];
	
	
	[testXML appendString:@"</questions>"];

	NSData* xml =[testXML dataUsingEncoding:NSUTF8StringEncoding];
	
	//Initialize Parser
	parser = [QuestionParser new];
	[parser parseData:xml];
	
	//Get the list of questions
	NSArray* questions = parser.questions;
	
	//Test Question Parser
	//Question 1
	Question *q1 =[questions objectAtIndex:0];
	STAssertEquals(q1.time,
                   5, 
                   @"FAILURE: time of Question 1.");
	
	
    //Check Question Type
	NSComparisonResult doesTypeMatch = [q1.type compare:@"Fill in the blank"];
    STAssertEquals(doesTypeMatch,
                   NSOrderedSame, 
                   @"FAILURE: type of Question 1.");
	
	//Check Question Sentence
	doesTypeMatch = [q1.sentence compare:@"It smacked my face all of a su_den."];
    STAssertEquals(doesTypeMatch,
                   NSOrderedSame, 
                   @"FAILURE: sentence of Question 1.");
	
	//Setup test arrays
	NSArray* choices = [NSArray arrayWithObjects:@"h", @"p", @"d", @"x", nil];
	NSArray* points = [NSArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:10],[NSNumber numberWithInt:0],nil];
	
	
	
	//Check to see if the points and choices are correct
	for (int i = 0; i < [q1.choices count]; i++) {
		doesTypeMatch = [[q1.choices objectAtIndex:i] compare:[choices objectAtIndex:i]];
		STAssertEquals(doesTypeMatch,
					   NSOrderedSame, 
					   @"FAILURE: choice of Question 1.");
		
		STAssertEquals([[points objectAtIndex:i] intValue],
					   [[q1.points objectAtIndex:i] intValue],
					   @"FAILURE: points of question 1 don't match");
	}
	
	
	 
	
	
	

}	
@end
