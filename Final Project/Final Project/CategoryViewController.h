//
//  ViewController2.h
//  Final Project
//
//  Created by Hung Ga 123 on 6/20/16.
//  Copyright © 2016 HungVu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Reachability/Reachability.h>
#import <TFHppleElement.h>
#import "CustomCell.h"
#import "xCategory.h"
#import "APIClient.h"
#import "ListStoryViewController.h"
@interface CategoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *categoryObjects;
@end
