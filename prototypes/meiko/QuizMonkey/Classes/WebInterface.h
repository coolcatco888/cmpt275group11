//
//  WebInterface.h
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 3/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Score.h"


@interface WebInterface : NSObject {
	NSString *url;
	NSArray *serverVariables;
	Score *score;
	NSMutableString *submitionString;

}

@property (assign) Score *score;

//@property (assign) NSString* url;
//@property (assign) NSDictionary* serverVariables;

- (WebInterface*)initWithURL:(NSString*)newUrl serverVariables:(NSArray*)newServerVariables;

- (void)appendVariableToSubmitionString:(NSString*)variable value:(NSString*)value;
- (void)submitHighScores;
- (void)retrievePersonalHighScores;
- (void)retrieveGlobalHighScores;

@end
