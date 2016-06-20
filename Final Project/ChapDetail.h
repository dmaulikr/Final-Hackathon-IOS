//
//  ChapDetail.h
//  Final Project
//
//  Created by Hung Ga 123 on 6/20/16.
//  Copyright © 2016 HungVu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChapID.h"
#import "Chapter.h"
#import "ChapterName.h"
#import "DateUpdate.h"
@interface ChapDetail : NSObject
@property ChapID *chapID;
@property Chapter *chapter;
@property ChapterName *chapterName;
@property DateUpdate *dateUpdate;
@end
