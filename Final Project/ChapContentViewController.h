//
//  ChapContentViewController.h
//  Final Project
//
//  Created by Hung Ga 123 on 6/21/16.
//  Copyright © 2016 HungVu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TFHppleElement.h>
#import "ChapContent.h"
#import "NextBtn.h"
#import "PreviewBtn.h"
#import "APIClient.h"
#import "CategoryViewController.h"
@interface ChapContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblChapContent;
- (IBAction)clickHomeBtn:(id)sender;
- (IBAction)clickNextBtn:(id)sender;
- (IBAction)clickPreviewBtn:(id)sender;
@property NSMutableArray *chapContentObjects;
@property NSMutableArray *nextBtnObjects;
@property NSMutableArray *previewBtnObjects;
-(void) loadChapContent:(NSString*)urlString nextBtn:(NSString*)nextBtnXpathQueryString;
-(void) loadChapContent:(NSString*)urlString previewBtn:(NSString*)previewBtnXpathQueryString;
-(void) loadChapContent:(NSString*)urlString chapContent:(NSString*)chapContentXpathQueryString;
@property NSString *urlString;
@end
