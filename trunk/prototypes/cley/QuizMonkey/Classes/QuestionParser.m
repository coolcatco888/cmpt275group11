/*
#import "QuestionParser.h"
#import "Book.h"

static NSSet *interestingKeys;

@implementation QuestionParser

+ (void)initialize
{
    if (!interestingKeys) {
        interestingKeys = [[NSSet alloc] initWithObjects:@"Title",
						   @"DetailPageURL", nil];
    }
}

- (void)dealloc
{
    [items release];
    [super dealloc];
}

- (BOOL)parseData:(NSData *)d
{
    // Release the old itemArray
    [items release];
	
    // Create a new, empty itemArray
    items = [[NSMutableArray alloc] init];
	
    // Create a parser
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:d];
    [parser setDelegate:self];
	
    // Do the parse
    [parser parse];
	
    [parser release];
	
    NSLog(@"items = %@", items);
    return YES;
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
    if ([elementName isEqual:@"Item"]) {
		
        // Create a dictionary for the title/url for the item
        questionInProgress = [[Book alloc] init];
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
    if ([elementName isEqual:@"Item"]) {
        [items addObject:questionInProgress];
		
        // Clear the current item
        [questionInProgress release];
        questionInProgress = nil;
        return;
    }
	
    // Is the current key complete?
    if ([elementName isEqual:keyInProgress]) {
        if ([elementName isEqual:@"DetailPageURL"]) {
            [questionInProgress setDetailPage:textInProgress];
        } else {
            [questionInProgress setTitle:textInProgress];
			
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
 */
