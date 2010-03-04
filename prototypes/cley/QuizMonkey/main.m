//
//  main.m
//  QuizMonkey
//
//  Created by Cley Tang on 2/15/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionParser.h"

int main(int argc, char *argv[]) {
    
	QuestionParser* parser = [QuestionParser new];
	[parser parseXMLFile: @"/Volumes/cleyt/cmpt275group11/prototypes/cley/QuizMonkey/sampleQuestion.xml"];
	
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}
