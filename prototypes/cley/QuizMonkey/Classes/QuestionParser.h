//
//  QuestionParser.h
//  QuizMonkey
//  
//  Code was modified from http://weblog.bignerdranch.com/?p=48
//  for the creation of QuestionParser.h and QuestionParser.m
//
//  Created by Cley Tang on 2/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import "Question.h"

@interface QuestionParser : NSObject
{
    NSMutableArray *items;
    Question *questionInProgress;
    NSString *keyInProgress;
    NSMutableString *textInProgress;
}
- (BOOL)parseXMLFile:(NSString *)pathToFile;
- (NSArray *)items;
@end
