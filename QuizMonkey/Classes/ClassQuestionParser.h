//
//  ClassQuestionParser.m
//  QuizMonkey
//
//  Created by Ariel on 08/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectQuestion.h"


@interface ClassQuestionParser : NSObject {
	NSMutableArray *Questions;
	ObjectQuestion *InProgress_Question;
	NSString *InProgress_Element;
	NSString *InProgress_Text;
}

@property (assign) NSMutableArray *Questions;



-(NSMutableArray *)LoadXMLQuestions:(NSString *)FileName;
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
-(void)dealloc;

@end


