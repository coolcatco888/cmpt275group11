//
//  SampleUnitTestCase.m
//  UnitTest1
//
//  Created by Tony Yang on 3/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SampleUnitTestCase.h"
#import "QuestionParser.h"

@implementation SampleUnitTestCase
- (void)testTestFramework
{
	
	//Initialize Parser
	QuestionParser* parser = [QuestionParser new];
	
	
	NSString* testXML = @"<questions><question><type>PickOutNouns</type><image>image.jpg</image><sentence></sentence><answer>Cats </answer><answer>fish.</answer><point>1</point><point>2</point><choice>Cats </choice><choice>eat </choice><choice>tasty </choice><choice>fish.</choice><time>20</time></question>";
	[testXML stringByAppendingString: @"<question><type>FillInBlank</type><image>image.jpg</image><sentence>I love my _unt.</sentence>"];
	[testXML stringByAppendingString: @"<answer>a</answer><point>1</point><choice>a</choice><choice>b</choice><choice>c</choice><choice>d</choice><time>10</time></question></questions>"];
	
	NSData* xml =[testXML dataUsingEncoding:NSUTF8StringEncoding];
	
	//Parse the Data
	[parser parseData: xml];
	
	//Get the list of questions
	NSArray* questions = [parser items];
	
	
    NSString *Q1type = @"PickOutNouns";
	Question *q1 =[questions objectAtIndex:0];
	
	NSComparisonResult doesTypeMatch = [Q1type compare:q1.type];
    STAssertEquals(doesTypeMatch,
                   NSOrderedSame, 
                   @"FAILURE: type of Question 1.");
	
	
	NSString *Q1sentence = @"";
	NSComparisonResult doesSentenceMatch = [Q1sentence compare:q1.sentence];
	STAssertEquals(doesSentenceMatch,
                   NSOrderedSame, 
                   @"FAILURE: sentence of Question 1.");
	
	
    //NSUInteger Q1time = 20;
	int Q1time = 20;
    STAssertEquals(Q1time,
                   q1.time,
                   @"FAILURE: time of Question 1.");
}
@end
