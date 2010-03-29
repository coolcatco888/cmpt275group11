//
//  WebInterface.m
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 3/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WebInterface.h"


@implementation WebInterface

@synthesize score;
//@synthesize url;
//@synthesize serverVariables;

- init {
	url = @"http://quizmonkey.x10hosting.com/submit.php?";
	serverVariables = [NSArray arrayWithObjects:@"username",@"password",@"timeleft",@"points",@"maxpoints",nil];
	submitionString = [NSMutableString stringWithCapacity:500];
	return self;
}

- (WebInterface*)initWithURL:(NSString*)newUrl serverVariables:(NSArray*)newServerVariables {
	self = [super init];
	url = newUrl;
	serverVariables = [newServerVariables copy];
	return self;
}

- (void)submitHighScores {
	NSLog(@"here2");
	
	[submitionString appendString:url];
	
	[self appendVariableToSubmitionString:[serverVariables objectAtIndex:0] value:[score studentID]];
	[submitionString appendString:@"&"];
	[self appendVariableToSubmitionString:[serverVariables objectAtIndex:1] value:[score password]];
	[submitionString appendString:@"&"];
	[self appendVariableToSubmitionString:[serverVariables objectAtIndex:2] value:[[NSNumber numberWithInt:[score timeLeft]] stringValue]];
	[submitionString appendString:@"&"];
	[self appendVariableToSubmitionString:[serverVariables objectAtIndex:3] value:[[NSNumber numberWithInt:[score points]] stringValue]];
	[submitionString appendString:@"&"];
	[self appendVariableToSubmitionString:[serverVariables objectAtIndex:4] value:[[NSNumber numberWithInt:[score maxPoints]]  stringValue]];
	
	NSLog(submitionString);
	
	
	
	[NSData dataWithContentsOfURL:[NSURL URLWithString:submitionString]];
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
