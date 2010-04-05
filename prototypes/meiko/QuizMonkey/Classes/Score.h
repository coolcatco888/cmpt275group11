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
	NSString *firstName;
	NSString *lastName;
	NSString *email;
	NSString *password;

	NSUInteger scoreID;
	NSUInteger timeLeft;
	NSUInteger points;
	NSUInteger maxPoints;
	NSDate *date;
}

@property (assign) NSString *studentID;
@property (assign) NSString *firstName;
@property (assign) NSString *lastName;
@property (assign) NSString *email;
@property (assign) NSString *password;
@property (assign) NSUInteger scoreID;
@property (assign) NSUInteger timeLeft;
@property (assign) NSUInteger points;
@property (assign) NSUInteger maxPoints;
@property (assign) NSDate *date;
@end
