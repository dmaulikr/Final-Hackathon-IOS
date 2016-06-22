//
//  ListChapViewController.h
//  Final Project
//
//  Created by Hung Ga 123 on 6/20/16.
//  Copyright © 2016 HungVu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TFHppleElement.h>
#import "CustomCell3.h"
#import "ChapDetail.h"
#import "Summary.h"
#import "APIClient.h"
#import "ChapContentViewController.h"

@interface ListChapViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *chapDetailObjects;
@property NSMutableArray *summaryObjects;
-(void) loadListChap:(NSString*)UrlString chapterName:(NSString*)chapterNameXpathQueryString;
-(void) loadSummary:(NSString*)urlString summaryContent:(NSString*)summaryContentXpathQueryString rating:(NSString*)ratingXpathQueryString;
@property (weak, nonatomic) IBOutlet UILabel *lblSummaryContent;
@property (weak, nonatomic) IBOutlet UILabel *lblRating;
@property NSString *urlString;
@end
