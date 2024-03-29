//
//  QuestionParser.m
//  QuizMonkey
//
//  Created by Cley Tang on 3/12/10.
//
//  Worked on by Cley, Ariel, Tony, Meiko, Daniel
//
//  Known Bugs: See the header file
//
//  Changes: See the header file
//
//  Copyright 2010 Team Awesome. All rights reserved.
//

#import "QuestionParser.h"

@implementation QuestionParser

@synthesize questions;

-(NSMutableArray *)loadQuestionsFromXML:(NSString *)fileName{
	//Geting the filepath of the xml by using the fileName
	NSString* pathToXML = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
	//Geting the data inside the xml file by using the filapath
	NSData *fileData = [NSData dataWithContentsOfFile:pathToXML];
	//Calling the parseData function
	[self parseData: fileData];
	//Returning the questions array so that a super class can use it
	return questions;
}

- (BOOL)parseData:(NSData *)fileData {
	//Allocating the parser
	NSXMLParser *parser = [[NSXMLParser alloc] init];
	//Seting the data to be parsed
	[parser initWithData:fileData];
	//Seting the parser delegate
	[parser setDelegate:self];
	//Parsing
	[parser parse];
    return YES;
}


- (void) parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qName
	 attributes:(NSDictionary *)attributeDict{
	//If the name of the new element is eqal to "questions", we allocate the questions object
	if([elementName isEqualToString:@"questions"])	questions = [NSMutableArray arrayWithCapacity:100];
	//If the name of the new element is equal to "question" we allocate the single questionInProgress object
	if([elementName isEqualToString:@"question"])	questionInProgress = [Question new];
}


-(void)parser:(NSXMLParser *)parser
didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName{
	//Depending on the name of the element just finished, we assign the text in progress to the proper question atribute
	if([elementName isEqualToString:@"type"])		[questionInProgress setType:textInProgress];
	else if([elementName isEqualToString:@"image"])		[questionInProgress setImage:textInProgress];
	else if([elementName isEqualToString:@"choice"])	[questionInProgress addChoice:textInProgress];
	else if([elementName isEqualToString:@"point"])		[questionInProgress addPoint:[textInProgress intValue]];
	else if([elementName isEqualToString:@"time"])		[questionInProgress setTime: [textInProgress intValue]];
	else if([elementName isEqualToString:@"sentence"])	[questionInProgress setSentence:textInProgress];
	else if([elementName isEqualToString:@"question"])	[questions addObject:questionInProgress];
	[questionInProgress retain];
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	//Copying the new found string to textInProgress for later use
	textInProgress = [string copy];
}

- (void)dealloc{
	//Releasing the unessesary objects
	//The questions array object is not released because it is used by super classes long after the parser finishes
	[questionInProgress release];
	[textInProgress release];
    [super dealloc];
}

@end