
#import "QuestionParser.h"
#import "Question.h"

static NSSet *interestingKeys;

@implementation QuestionParser

+ (void)initialize
{
    if (!interestingKeys) {
        interestingKeys = [[NSSet alloc] initWithObjects:
						   @"question",
						   @"type",
						   @"image",
						   @"answer",
						   @"choice",
						   @"point",
						   @"time",
						   @"sentence",
						   nil];
    }
}

- (void)dealloc
{
    [items release];
    [super dealloc];
}

- (BOOL)parseData:(NSData *)d
{
	BOOL success = FALSE;
	
    // Release the old itemArray
    [items release];
	
    // Create a new, empty itemArray
    items = [[NSMutableArray alloc] init];
	
    // Create a parser
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:d];
    [parser setDelegate:self];
	
    // Do the parse
    success = [parser parse];
	
    [parser release];
	
    NSLog(@"items = %@", items);
    return success;
}


- (NSArray *)items
{
    return items;
}

#pragma mark Delegate calls

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"starting Element: %@", elementName);
	
    // Is it one of the attributes for the current item?
    if ([interestingKeys containsObject:elementName]) {
        keyInProgress = [elementName copy];
        // This is a string we will append to as the text arrives
        textInProgress = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    NSLog(@"ending Element: %@", elementName);
	
    // Is the current item complete?	 
	if ([elementName isEqual:@"question"]) {

		[items addObject:questionInProgress];
		
        // Clear the current item
        [questionInProgress release];
        questionInProgress = nil;
		
        return;
	}
	
    // Is the current key complete?
    if ([elementName isEqual:keyInProgress]) {
		NSString* currentText = [NSString stringWithString: textInProgress];
		
		//Process Tags within Question
        if ([elementName isEqual:@"type"]) {
			//Element Type must be the very first element in a question element
			//otherwise the questions will not be parsed correctly
			questionInProgress = [Question new];
			[questionInProgress setType:currentText];
        } else if ([elementName isEqual:@"image"]) {
			[questionInProgress setImage:currentText];
        } else if ([elementName isEqual:@"answer"]) {
			[questionInProgress addAnswer:currentText];
        } else if ([elementName isEqual:@"choice"]) {
			[questionInProgress addChoice:currentText];
        } else if ([elementName isEqual:@"point"]) {
			NSInteger newPoint = [currentText intValue];
			[questionInProgress addPoint: newPoint];
        } else if ([elementName isEqual:@"time"]) {
			[questionInProgress setTime: [currentText intValue]];
        } else if ([elementName isEqual:@"sentence"]) {
			[questionInProgress setSentence:currentText];
        }
		
        // Clear the text and key
        [textInProgress release];
        textInProgress = nil;
        [keyInProgress release];
        keyInProgress = nil;
    }
}

// This method can get called multiple times for the
// text in a single element
- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string
{
    [textInProgress appendString:string];
}
@end

