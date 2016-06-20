//
//  ViewController2.h
//  Final Project
//
//  Created by Hung Ga 123 on 6/20/16.
//  Copyright © 2016 HungVu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TFHppleElement.h>
#import "CustomCell.h"
#import "Category.h"
#import "APIClient.h"
#import "ViewController3.h"
@interface ViewController2 : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *categoryObjects;
@property ViewController3 *vcl3;
@end
