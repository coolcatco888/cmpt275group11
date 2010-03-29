//
//  ScoreParser.m
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 3/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ScoreParser.h"


@implementation ScoreParser
//http://quizmonkey.x10hosting.com/viewxml.php
- (NSMutableArray*)parseScoresFromData:(NSData *)xmlData {
	
	NSXMLParser *parser = [NSXMLParser new];
	[parser initWithData:xmlData];
	//Seting the parser delegate
	[parser setDelegate:self];
	//Parsing
	[parser parse];
	return scoreList;
}
- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict {
	if([elementName isEqualToString:@"scores"]) scoreList = [NSMutableArray arrayWithCapacity:100];
	if([elementName isEqualToString:@"score"]) scoreInProgress = [Score new];
}
-(void)parser:(NSXMLParser *)parser//The parser id
didEndElement:(NSString *)elementName//A string that contain the text of the element that was just finished reading
 namespaceURI:(NSString *)namespaceURI//Unused
qualifiedName:(NSString *)qName {
	if([elementName isEqualToString:@"userid"]) [scoreInProgress setStudentID:textInProgress];
	else if([elementName isEqualToString:@"firstname"]) [scoreInProgress setFirstName:textInProgress];
	else if([elementName isEqualToString:@"lastname"]) [scoreInProgress setLastName:textInProgress];
	else if([elementName isEqualToString:@"email"]) [scoreInProgress setEmail:textInProgress];
	else if([elementName isEqualToString:@"scoreid"]) [scoreInProgress setScoreID:[textInProgress intValue]];
	else if([elementName isEqualToString:@"timeleft"]) [scoreInProgress setTimeLeft:[textInProgress intValue]];
//	else if([elementName isEqualToString:@"date"]) [scoreInProgress setDate:textInProgress];
	else if([elementName isEqualToString:@"points"]) [scoreInProgress setPoints:[textInProgress intValue]];
	else if([elementName isEqualToString:@"maxpoints"]) [scoreInProgress setMaxPoints:[textInProgress intValue]];
	else if([elementName isEqualToString:@"score"]) {
		[scoreList addObject:scoreInProgress];
		[scoreInProgress release];
	}
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	textInProgress = [string copy];
}

@end
