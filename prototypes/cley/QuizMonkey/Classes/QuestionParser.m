
#import "QuestionParser.h"
#import "Question.h"

static NSSet *interestingKeys;

@implementation QuestionParser

+ (void)initialize
{
    if (!interestingKeys) {
        interestingKeys = [[NSSet alloc] initWithObjects:
						   @"type",
						   @"image", nil];
    }
}

- (void)dealloc
{
    [items release];
    [super dealloc];
}
 
 - (BOOL)parseXMLFile:(NSString *)pathToFile {
 
 // Release the old itemArray
 [items release];
 
 // Create a new, empty itemArray
 items = [[NSMutableArray alloc] init];
 
 BOOL success = FALSE;
 
 //Create Parser From File
 NSURL *xmlURL = [NSURL fileURLWithPath:pathToFile];
 NSXMLParser* addressParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
 
 //Setup parse
 [addressParser setDelegate:self];
 [addressParser setShouldResolveExternalEntities:YES];
 
 success = [addressParser parse]; // return value not used
 
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
	
    // Is it the start of a new item?
    if ([elementName isEqual:@"Question"]) {
		
        // Create a dictionary for the title/url for the item
        questionInProgress = [[Question alloc] init];
        return;
    }
	
    // Is it the title/url for the current item?
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
    if ([elementName isEqual:@"Question"]) {
        [items addObject:questionInProgress];
		
        // Clear the current item
        [questionInProgress release];
        questionInProgress = nil;
        return;
    }
	
    // Is the current key complete?
    if ([elementName isEqual:keyInProgress]) {
		
		//Process Tags within Question
        if ([elementName isEqual:@"type"]) {
			[questionInProgress setType:textInProgress];
        } else if ([elementName isEqual:@"image"]) {
			[questionInProgress setImage:textInProgress];
        } else if ([elementName isEqual:@"answer"]) {
			[questionInProgress addAnswer:textInProgress];
        } else if ([elementName isEqual:@"choice"]) {
			[questionInProgress addChoice:textInProgress];
        } else if ([elementName isEqual:@"point"]) {
			NSInteger newPoint = [textInProgress intValue];
			[questionInProgress addPoint: &newPoint];
        } else if ([elementName isEqual:@"time"]) {
			[questionInProgress setTime: [textInProgress intValue]];
        } else if ([elementName isEqual:@"sentence"]) {
			[questionInProgress setSentence:textInProgress];
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

