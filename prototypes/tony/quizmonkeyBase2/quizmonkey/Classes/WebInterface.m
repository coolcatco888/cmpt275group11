//
//  WebInterface.m
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 3/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WebInterface.h"


@implementation WebInterface

//@synthesize url;
//@synthesize serverVariables;

- (WebInterface*)initWithURL:(NSString*)newUrl serverVariables:(NSArray*)newServerVariables {
	self = [super init];
	url = newUrl;
	serverVariables = [newServerVariables copy];
	return self;
}

- (void)submitHighScores {
	[submitionString appendString:url];
	
	[self appendVariableToSubmitionString:[serverVariables objectAtIndex:0] value:[score studentID]];
	[self appendVariableToSubmitionString:[serverVariables objectAtIndex:1] value:[score firstName]];
	[self appendVariableToSubmitionString:[serverVariables objectAtIndex:2] value:[score lastName]];
	[self appendVariableToSubmitionString:[serverVariables objectAtIndex:3] value:[score email]];
	[self appendVariableToSubmitionString:[serverVariables objectAtIndex:4] value:[score scoreID]];
	[self appendVariableToSubmitionString:[serverVariables objectAtIndex:5] value:[score points]];
	[self appendVariableToSubmitionString:[serverVariables objectAtIndex:6] value:[score date]];
	
	
	NSURL *submitionURL;
	[submitionURL initWithString:submitionString];
}

- (void)appendVariableToSubmitionString:(NSString*)variable value:(NSString*)value {
	[submitionString appendString:variable];
	[submitionString appendString:@"="];
	[submitionString appendString:value];
}

- (void)retrievePersonalHighScores {

}

- (void)retrieveGlobalHighScores {

}

@end
