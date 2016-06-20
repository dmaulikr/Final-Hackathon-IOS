//
//  ViewController3.h
//  Final Project
//
//  Created by Hung Ga 123 on 6/20/16.
//  Copyright © 2016 HungVu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TFHppleElement.h>
#import "CustomCell2.h"
#import "APIClient.h"
#import "StoryIntroduce.h"
@interface ViewController3 : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *storyObjects;
-(void) loadListStorys:(NSString*)storyUrlString;
@end
