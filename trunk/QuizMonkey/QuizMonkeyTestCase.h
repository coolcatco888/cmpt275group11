//
//  QuizMonkeyTestCase.h
//  QuizMonkey
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
#import "Question.h"

@interface QuizMonkeyTestCase : SenTestCase {
	QuestionParser* parser;
}
- (void)testTestFramework;
@end
