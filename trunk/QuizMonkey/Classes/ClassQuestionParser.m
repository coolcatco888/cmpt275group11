#import "ClassQuestionParser.h"

@implementation ClassQuestionParser

@synthesize Questions;

-(NSMutableArray *)LoadXMLQuestions:(NSString *)FileName{
	FileName = [[NSBundle mainBundle] pathForResource:FileName ofType:@"xml"];
	NSData *FileData = [NSData dataWithContentsOfFile:FileName];
	NSXMLParser *QuestionParser = [[NSXMLParser alloc] init];
	[QuestionParser initWithData:FileData];
	[QuestionParser setDelegate:self];
	[QuestionParser parse];
	return Questions;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	if([elementName isEqualToString:@"questions"])	Questions = [NSMutableArray arrayWithCapacity:100];
	if([elementName isEqualToString:@"question"])	InProgress_Question = [ObjectQuestion new];
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	NSLog(InProgress_Text);
	if([elementName isEqualToString:@"type"])		[InProgress_Question setType:InProgress_Text];
	else if([elementName isEqualToString:@"image"])		[InProgress_Question setPic_Name:InProgress_Text];
	else if([elementName isEqualToString:@"choice"])	[InProgress_Question addChoices_Words:InProgress_Text];
	else if([elementName isEqualToString:@"point"])		[InProgress_Question addChoices_Points:[InProgress_Text intValue]];
	else if([elementName isEqualToString:@"time"])		[InProgress_Question setTime: [InProgress_Text intValue]];
	else if([elementName isEqualToString:@"sentence"])	[InProgress_Question setSentence:InProgress_Text];
	else if([elementName isEqualToString:@"question"])	[Questions addObject:InProgress_Question];
	[InProgress_Text release];
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	InProgress_Text = [string copy];
}

- (void)dealloc{
    [super dealloc];
}

@end