//
//  main.m
//  QuizMonkey
//
//  Created by Cley Tang on 2/15/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionParser.h"

int main(int argc, char *argv[]) {
    
	//Initialize Parser
	QuestionParser* parser = [QuestionParser new];
	
	//Create a data object from xml
	NSString * filePath = [[NSBundle mainBundle] pathForResource:@"sampleQuestion" ofType:@"xml"];
	NSData * xml = [NSData dataWithContentsOfFile:filePath];
	
	//Parse the Data
	[parser parseData: xml];
	
	//Get the list of questions
	NSArray* questions = [parser items];
	
	
	[questions release];
	
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}
