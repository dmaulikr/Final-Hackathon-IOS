//
//  ChapContentViewController.h
//  Final Project
//
//  Created by Hung Ga 123 on 6/21/16.
//  Copyright © 2016 HungVu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChapContent.h"
#import <TFHppleElement.h>
#import "APIClient.h"
#import "CategoryViewController.h"
@interface ChapContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblChapContent;
@property NSMutableArray *chapContentObjects;
- (IBAction)clickHomeBtn:(id)sender;
-(void) loadChapContent:(NSString*)UrlString chapContent:(NSString*)chapContentXpathQueryString;
@end
