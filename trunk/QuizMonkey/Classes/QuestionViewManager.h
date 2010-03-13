//
//  QuestionViewManager.h
//  QuizMonkey
//
//  This class is responsible for displaying the questions on the screen along with managing the game logic
//
//  Created by Cley Tang on 3/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface QuestionViewManager : NSObject {
	
	IBOutlet UIView *mainMenuScreen;//Holds a reference to the main menu
	IBOutlet UIView *questionScreen;//Will be set as a subview for the main menu
	NSMutableArray* questions;//Holds the list of questions
	NSMutableArray* screenObjects;//Holds all of the buttons/labels/images in the view

}

@property (assign) IBOutlet UIView* mainMenuScreen;
@property (assign) IBOutlet UIView* questionScreen;
@property (assign) NSMutableArray* questions;
@property (assign) NSMutableArray* screenObjects;

-(void) createButton:(NSString*) title 
					:(int) x 
					:(int) y 
					:(int) width 
					:(int) height 
					:(SEL) buttonActionFunction;

-(void) loadQuestionToView: (NSUInteger) questionIndex;


@end
