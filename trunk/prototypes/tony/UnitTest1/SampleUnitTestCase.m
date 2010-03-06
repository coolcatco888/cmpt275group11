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
	
	//Create a data object from xml
	NSString * filePath = [[NSBundle mainBundle] pathForResource:@"sampleQuestion" ofType:@"xml"];
	NSData * xml = [NSData dataWithContentsOfFile:filePath];
	
	//Parse the Data
	[parser parseData: xml];
	
	//Get the list of questions
	NSArray* questions = [parser items];
	
	
    NSString *Q1type = @"PickOutWords";
    STAssertEquals(Q1type,
                   [questions objectAtIndex:0].type,
                   @"FAILURE");
	
    NSUInteger uint_1 = 4;
    NSUInteger uint_2 = 4;
    STAssertEquals(uint_1,
                   uint_2,
                   @"FAILURE");
}
@end
