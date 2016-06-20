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
#import "APIClient.h"
@interface ListChapViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *chapDetailObjects;
-(void) loadListChap:(NSString*)chapUrlString;
@end
