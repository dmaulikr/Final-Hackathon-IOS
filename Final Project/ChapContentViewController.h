//
//  ChapContentViewController.h
//  Final Project
//
//  Created by Hung Ga 123 on 6/21/16.
//  Copyright © 2016 HungVu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TFHppleElement.h>

#import "Image.h"
#import "Next.h"
#import "Preview.h"

#import "APIClient.h"
#import "CategoryViewController.h"
#import <UIActivityIndicator-for-SDWebImage+UIButton/UIImageView+UIActivityIndicatorForSDWebImage.h>
@interface ChapContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)clickHomeBtn:(id)sender;
- (IBAction)clickNextBtn:(id)sender;
- (IBAction)clickPreviewBtn:(id)sender;
@property NSMutableArray *imageObjects;
@property NSMutableArray *nextObjects;
@property NSMutableArray *previewObjects;
-(void) loadChapContent:(NSString*)urlString next:(NSString*)nextXpathQueryString;
-(void) loadChapContent:(NSString*)urlString preview:(NSString*)previewXpathQueryString;
-(void) loadChapContent:(NSString*)urlString image:(NSString*)imageXpathQueryString;
@property NSString *urlString;
@end
