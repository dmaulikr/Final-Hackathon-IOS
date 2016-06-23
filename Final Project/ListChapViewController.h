//
//  ListChapViewController.h
//  Final Project
//
//  Created by Hung Ga 123 on 6/20/16.
//  Copyright © 2016 HungVu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChapterName.h"
#import "DateUpdate.h"
#import "SummaryContent.h"

#import <TFHppleElement.h>
#import "CustomCell3.h"
#import "APIClient.h"
#import "ChapContentViewController.h"

@interface ListChapViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *summaryContentObjects;
@property NSMutableArray *dateUpdateObjects;
@property NSMutableArray *chapterNameObjects;
-(void) loadListChap:(NSString*)UrlString chapterName:(NSString*)chapterNameXpathQueryString;
-(void) loadListChap:(NSString*)urlString summaryContent:(NSString*)summaryContentXpathQueryString;
-(void) loadListChap:(NSString*)urlString dateUpdate:(NSString*)dateUpdateXpathQueryString;
@property (weak, nonatomic) IBOutlet UILabel *lblSummaryContent;
@property NSString *urlString;
@end
