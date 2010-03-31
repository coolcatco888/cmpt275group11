//
//  ScoreParser.h
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 3/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Score.h"


@interface ScoreParser : NSObject {
	NSMutableArray *scoreList;
	Score *scoreInProgress;
	NSString *textInProgress;
}


-(NSMutableArray*)parseScoresFromData:(NSData *)xmlData;//This function takes in fileData, sets up the xml parser with the fileData, and starts the parser
//The following function is called by the xml parser when it reaches the end of an xml element
-(void)parser:(NSXMLParser *)parser//The parser id
didEndElement:(NSString *)elementName//A string that contain the text of the element that was just finished reading
 namespaceURI:(NSString *)namespaceURI//Unused
qualifiedName:(NSString *)qName;//Unused
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;//The xml parser calls this function when it reaches the end of a string inside any given xml element

@end
