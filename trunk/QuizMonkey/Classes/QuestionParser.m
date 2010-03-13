#import "QuestionParser.h"

@implementation QuestionParser

@synthesize questions;

-(NSMutableArray *)loadQuestionsFromXML:(NSString *)fileName{
	NSString* pathToXML = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
	NSData *fileData = [NSData dataWithContentsOfFile:pathToXML];
	NSXMLParser *parser = [[NSXMLParser alloc] init];
	[parser initWithData:fileData];
	[parser setDelegate:self];
	[parser parse];
	return questions;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
 namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 
   attributes:(NSDictionary *)attributeDict{
	if([elementName isEqualToString:@"questions"])	questions = [NSMutableArray arrayWithCapacity:100];
	if([elementName isEqualToString:@"question"])	questionInProgress = [Question new];
}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
 namespaceURI:(NSString *)namespaceURI 
qualifiedName:(NSString *)qName {
	NSLog(textInProgress);
	if([elementName isEqualToString:@"type"])		[questionInProgress setType:textInProgress];
	else if([elementName isEqualToString:@"image"])		[questionInProgress setImage:textInProgress];
	else if([elementName isEqualToString:@"choice"])	[questionInProgress addChoice:textInProgress];
	else if([elementName isEqualToString:@"point"])		[questionInProgress addPoint:[textInProgress intValue]];
	else if([elementName isEqualToString:@"time"])		[questionInProgress setTime: [textInProgress intValue]];
	else if([elementName isEqualToString:@"sentence"])	[questionInProgress setSentence:textInProgress];
	else if([elementName isEqualToString:@"question"])	[questions addObject:questionInProgress];
	[textInProgress release];
	[elementInProgress release];
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	textInProgress = [string copy];
}

- (void)dealloc{
    [super dealloc];
}

@end