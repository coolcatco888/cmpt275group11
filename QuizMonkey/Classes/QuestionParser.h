//
//  QuestionParser.m
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
#import "Question.h"


@interface QuestionParser : NSObject {
	NSMutableArray *questions;
	Question *questionInProgress;
	NSString *elementInProgress;
	NSString *textInProgress;
}

@property (assign) NSMutableArray *questions;

-(NSMutableArray *)loadQuestionsFromXML:(NSString *)fileName;
-(void)parser:(NSXMLParser *)parser didEndElement
			 :(NSString *)elementName namespaceURI
			 :(NSString *)namespaceURI qualifiedName
			 :(NSString *)qName;
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
-(void)dealloc;
- (BOOL)parseData:(NSData *)fileData;

@end


