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
	
	
	NSString* testXML = @"<questions><question><type>PickOutNouns</type><image>image.jpg</image><sentence></sentence><answer>Cats </answer><answer>fish.</answer><point>1</point><point>2</point><choice>Cats </choice><choice>eat </choice><choice>tasty </choice><choice>fish.</choice><time>20</time></question><question><type>FillInBlank</type><image>image.jpg</image><sentence>I love my _unt.</sentence><answer>a</answer><point>1</point><choice>a</choice><choice>b</choice><choice>c</choice><choice>d</choice><time>10</time></question></questions>";
	
	NSData* xml =[testXML dataUsingEncoding:NSUTF8StringEncoding];
	
	//Parse the Data
	[parser parseData: xml];
	
	//Get the list of questions
	NSArray* questions = [parser items];
	
	//Test Question Parser
	//Question 1
	
	Question *q1 =[questions objectAtIndex:0];
	
    NSString *Q1type = @"PickOutNouns";
	NSComparisonResult doesTypeMatch = [Q1type compare:q1.type];
    STAssertEquals(doesTypeMatch,
                   NSOrderedSame, 
                   @"FAILURE: type of Question 1.");
	
	
	NSString *Q1sentence = @"";
	NSComparisonResult doesSentenceMatch = [Q1sentence compare:q1.sentence];
	STAssertEquals(doesSentenceMatch,
                   NSOrderedSame, 
                   @"FAILURE: sentence of Question 1.");
	
	NSString *Q1image = @"image.jpg";
	NSComparisonResult doesImageMatch = [Q1image compare:q1.image];
	STAssertEquals(doesImageMatch,
                   NSOrderedSame, 
                   @"FAILURE: image of Question 1.");
	
	NSString *Q1answer1= @"Cats ";
	NSComparisonResult doesAnswer1Match = [Q1answer1 compare:[q1.answers objectAtIndex:0]];
	STAssertEquals(doesAnswer1Match,
                   NSOrderedSame, 
                   @"FAILURE: answer1 of Question 1.");
	
	NSString *Q1answer2= @"fish.";
	NSComparisonResult doesAnswer2Match = [Q1answer2 compare:[q1.answers objectAtIndex:1]];
	STAssertEquals(doesAnswer2Match,
                   NSOrderedSame, 
                   @"FAILURE: answer2 of Question 1.");
	
	NSInteger Q1point1=1;
	STAssertEquals([NSNumber numberWithInteger:Q1point1],
                   [q1.points objectAtIndex:0],
                   @"FAILURE: the first point of Question 1.");
	
	NSInteger Q1point2=2;
	STAssertEquals([NSNumber numberWithInteger:Q1point2],
                   [q1.points objectAtIndex:1],
                   @"FAILURE: the second point of Question 1.");
	
	NSString *Q1choice= @"Cats ";
	NSComparisonResult doesChoiceMatch = [Q1choice compare:[q1.choices objectAtIndex:0]];
	STAssertEquals(doesChoiceMatch,
                   NSOrderedSame, 
                   @"FAILURE: Choice 1 of Question 1.");
	
	Q1choice= @"eat ";
	doesChoiceMatch = [Q1choice compare:[q1.choices objectAtIndex:1]];
	STAssertEquals(doesChoiceMatch,
                   NSOrderedSame, 
                   @"FAILURE: Choice 2 of Question 1.");
	
	Q1choice= @"tasty ";
	doesChoiceMatch = [Q1choice compare:[q1.choices objectAtIndex:2]];
	STAssertEquals(doesChoiceMatch,
                   NSOrderedSame, 
                   @"FAILURE: Choice 3 of Question 1.");
	
	Q1choice= @"fish.";
	doesChoiceMatch = [Q1choice compare:[q1.choices objectAtIndex:3]];
	STAssertEquals(doesChoiceMatch,
                   NSOrderedSame, 
                   @"FAILURE: Choice 4 of Question 1.");
	
	int Q1time = 20;
    STAssertEquals(Q1time,
                   q1.time,
                   @"FAILURE: time of Question 1.");
	
	//Question 2
	Question *q2 =[questions objectAtIndex:1];
	
	NSString *Q2type = @"FillInBlank";
	doesTypeMatch = [Q2type compare:q2.type];
    STAssertEquals(doesTypeMatch,
                   NSOrderedSame, 
                   @"FAILURE: type of Question 2.");
	
	
	NSString *Q2sentence = @"I love my _unt.";
	doesSentenceMatch = [Q2sentence compare:q2.sentence];
	STAssertEquals(doesSentenceMatch,
                   NSOrderedSame, 
                   @"FAILURE: sentence of Question 2.");
	
	NSString *Q2image = @"image.jpg";
	doesImageMatch = [Q2image compare:q2.image];
	STAssertEquals(doesImageMatch,
                   NSOrderedSame, 
                   @"FAILURE: image of Question 2.");
	
	NSString *Q2answer= @"a";
	NSComparisonResult doesAnswerMatch = [Q2answer compare:[q2.answers objectAtIndex:0]];
	STAssertEquals(doesAnswerMatch,
                   NSOrderedSame, 
                   @"FAILURE: answer1 of Question 2.");
	
	NSInteger Q2point=1;
	STAssertEquals([NSNumber numberWithInteger:Q2point],
                   [q2.points objectAtIndex:0],
                   @"FAILURE: the first point of Question 2.");
	
	NSString *Q2choice= @"a";
	doesChoiceMatch = [Q2choice compare:[q2.choices objectAtIndex:0]];
	STAssertEquals(doesChoiceMatch,
                   NSOrderedSame, 
                   @"FAILURE: Choice 1 of Question 2.");
	
	Q2choice= @"b";
	doesChoiceMatch = [Q2choice compare:[q2.choices objectAtIndex:1]];
	STAssertEquals(doesChoiceMatch,
                   NSOrderedSame, 
                   @"FAILURE: Choice 2 of Question 2.");
	
	Q2choice= @"c";
	doesChoiceMatch = [Q2choice compare:[q2.choices objectAtIndex:2]];
	STAssertEquals(doesChoiceMatch,
                   NSOrderedSame, 
                   @"FAILURE: Choice 3 of Question 2.");
	
	Q2choice= @"d";
	doesChoiceMatch = [Q2choice compare:[q2.choices objectAtIndex:3]];
	STAssertEquals(doesChoiceMatch,
                   NSOrderedSame, 
                   @"FAILURE: Choice 4 of Question 2.");
	
	int Q2time = 10;
    STAssertEquals(Q2time,
                   q2.time,
                   @"FAILURE: time of Question 2.");
	
	//Test Question methods
	Question* testQuestion=[Question new];
	//testQuestion 
	
	[testQuestion release];
	
}
@end
