//
//  ClassQuestionParser.m
//  QuizMonkey
//
//  Created by Ariel on 08/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"


@interface ClassQuestionParser : NSObject {
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

@end


