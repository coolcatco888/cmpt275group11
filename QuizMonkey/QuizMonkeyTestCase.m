//
//  QuizMonkeyTestCase.m
//  QuizMonkey
//
//	This is implement file of XML parser testing. At first, parser decodes a String,
//	which contains XML documents, and then it produces a question object. After that,
//	this test will check every attribute of the question, and it will show up message(s)
//	if test is failed.
//
//  Created by Tony Yang on 3/14/10.
//
//  Worked on by Cley, Ariel, Tony, Meiko, Daniel
//
//  Known Bugs: See the header file
//
//  Changes: See the header file
//
//  Copyright 2010 Team Awesome. All rights reserved.
//

#import "QuizMonkeyTestCase.h"

@implementation QuizMonkeyTestCase

- (void)testTestFramework {
	//creating XML document
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
	QuestionParser* parser = [QuestionParser new];
	[parser parseData:xml];
	
	//Get the list of questions
	NSArray* questions = parser.questions;
	
	//Test Question Parser
	//Question 1
	Question *testQuestion1 =[questions objectAtIndex:0];
	STAssertEquals(testQuestion1.time,
                   5, 
                   @"FAILURE: time of Question 1.");
	
	
    //Check Question Type
	NSComparisonResult doesTypeMatch = [testQuestion1.type compare:@"Fill in the blank"];
    STAssertEquals(doesTypeMatch,
                   NSOrderedSame, 
                   @"FAILURE: type of Question 1.");
	
	//Check Question Sentence
	doesTypeMatch = [testQuestion1.sentence compare:@"It smacked my face all of a su_den."];
    STAssertEquals(doesTypeMatch,
                   NSOrderedSame, 
                   @"FAILURE: sentence of Question 1.");
	
	//Setup test arrays
	NSArray* choices = [NSArray arrayWithObjects:@"h", @"p", @"d", @"x", nil];
	NSArray* points = [NSArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:10],[NSNumber numberWithInt:0],nil];
	
	
	
	//Check to see if the points and choices are correct
	for (int i = 0; i < [testQuestion1.choices count]; i++) {
		doesTypeMatch = [[testQuestion1.choices objectAtIndex:i] compare:[choices objectAtIndex:i]];
		STAssertEquals(doesTypeMatch,
					   NSOrderedSame, 
					   @"FAILURE: choice of Question 1.");
		
		STAssertEquals([[points objectAtIndex:i] intValue],
					   [[testQuestion1.points objectAtIndex:i] intValue],
					   @"FAILURE: points of question 1 don't match");
	}
	
	
	 
	
	
	

}	
@end
