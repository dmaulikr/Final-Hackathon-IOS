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
#import "ListChapViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ListStoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
- (IBAction)clickPreviewPage:(id)sender;
- (IBAction)clickNextPage:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSString *urlString;
@property NSMutableArray *storyObjects;
-(void) loadListStorys:(NSString*)urlString storyName:(NSString*)storyNameXpathQueryString currentChap:(NSString*)currentChapXpathQueryString author:(NSString*)authorXpathQueryString cover:(NSString*)coverXpathQueryString;
-(NSString*) param:(int) x;
@end
