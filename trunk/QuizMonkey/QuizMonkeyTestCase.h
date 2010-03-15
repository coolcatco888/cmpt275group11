//
//  QuizMonkeyTestCase.h
//  QuizMonkey
//
//  Created by Tony Yang on 3/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

#import "QuestionParser.h"
#import "Question.h"

@interface QuizMonkeyTestCase : SenTestCase {
	QuestionParser* parser;
}
- (void)testTestFramework;
@end
