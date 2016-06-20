//
//  StoryIntroduce.h
//  Final Project
//
//  Created by Hung Ga 123 on 6/20/16.
//  Copyright © 2016 HungVu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cover.h"
#import "CurrentChap.h"
#import "StoryName.h"
@interface StoryIntroduce : NSObject
@property Cover *cover;
@property CurrentChap *currentChap;
@property StoryName *storyName;
@end
