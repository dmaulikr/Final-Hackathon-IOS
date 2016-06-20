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
@interface ListChapViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *chapDetailObjects;
@property NSMutableArray *summaryObjects;
-(void) loadListChap:(NSString*)chapUrlString;
-(void) loadSummary:(NSString*)chapUrlString;
@property (weak, nonatomic) IBOutlet UILabel *lblSummaryContent;
@property (weak, nonatomic) IBOutlet UILabel *lblRating;
@end
