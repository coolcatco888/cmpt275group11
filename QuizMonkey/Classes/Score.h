//
//  Score.h
//  QuizMonkey
//
//  Created by Ariel Lorenzo-Luaces on 3/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Score : NSObject {
	NSString *studentID;
	NSString *password;
	NSUInteger timeLeft;
	NSUInteger points;
	NSUInteger maxPoints;
}

@property (assign) NSString *studentID;
@property (assign) NSString *password;
@property (assign) NSUInteger timeLeft;
@property (assign) NSUInteger points;
@property (assign) NSUInteger maxPoints;
@end
