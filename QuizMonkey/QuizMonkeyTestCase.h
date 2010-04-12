//
//  QuizMonkeyTestCase.h
//  QuizMonkey
//
//	This is head file of XML parser testing. At first, parser decodes a String,
//	which contains XML documents, and then it produces a question object. After that,
//	this test will check every attribute of the question, and it will show up message(s)
//	if test is failed.
//
//  Created by Tony Yang on 3/14/10.
//
//  Worked on by Cley, Ariel, Tony, Meiko, Daniel
//
//  Known Bugs: none
//
//  Changes:
//   - 1.0 - Implemented
//
//  Copyright 2010 Team Awesome. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "QuestionParser.h"


@interface QuizMonkeyTestCase : SenTestCase {
	
}
- (void)testTestFramework;//testing method
@end
