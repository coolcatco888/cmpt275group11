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
	NSString *password;
	NSString *email;
	
	NSString *scoreID;
	NSDate *date;
	NSUInteger timeLeft;
	NSUInteger points;
	NSUInteger maxPoints;
}

@property (assign) NSString *studentID;
@property (assign) NSString *firstName;
@property (assign) NSString *lastName;
@property (assign) NSString *password;
@property (assign) NSString *email;

@property (assign) NSString *scoreID;
@property (assign) NSDate *date;
@property (assign) NSUInteger timeLeft;
@property (assign) NSUInteger points;
@property (assign) NSUInteger maxPoints;
@end
