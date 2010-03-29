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
	NSMutableArray *questions;//An array of all the questions loaded from the XML
	Question *questionInProgress;//Holds the question object currently in progress
	NSString *textInProgress;//Holds the most recent text inside the current xml element
}

@property (assign) NSMutableArray *questions;

-(NSMutableArray *)loadQuestionsFromXML:(NSString *)fileName;//The functions that takes the xml filename, gets the all the data from the xml file, and calls the parseData fucntion
-(BOOL)parseData:(NSData *)fileData;//This function takes in fileData, sets up the xml parser with the fileData, and starts the parser
//The following function is called by the xml parser when it reaches the end of an xml element
-(void)parser:(NSXMLParser *)parser//The parser id
	didEndElement:(NSString *)elementName//A string that contain the text of the element that was just finished reading
	namespaceURI:(NSString *)namespaceURI//Unused
	qualifiedName:(NSString *)qName;//Unused
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;//The xml parser calls this function when it reaches the end of a string inside any given xml element
-(void)dealloc;//dealocating the question parser object
-(BOOL)isQuestionValid:(Question*) question;//Validates whether a parsed question is correct/valid
//-(BOOL)isImageValid:(NSString *)image //validates whether or not the image can be loaded

@end


