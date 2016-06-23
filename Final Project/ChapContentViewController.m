//
//  ChapContentViewController.m
//  Final Project
//
//  Created by Hung Ga 123 on 6/21/16.
//  Copyright © 2016 HungVu. All rights reserved.
//

#import "ChapContentViewController.h"
@interface ChapContentViewController ()
@property NSInteger pageIndex;
@end

@implementation ChapContentViewController
#pragma mark - Click home button
- (IBAction)clickHomeBtn:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    CategoryViewController *categoryVCL = [sb instantiateViewControllerWithIdentifier:@"CategoryViewController"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:categoryVCL animated:YES completion:^{
            }];
        });
    });
}
#pragma mark - Image
-(void) loadChapContent:(NSString*)urlString image:(NSString *)imageXpathQueryString {
    NSMutableArray *newImages = [[NSMutableArray alloc] init];
    NSArray *chapterNameNodes = [[APIClient sharedInstance] loadFromUrl:urlString
                                                   withXpathQueryString:imageXpathQueryString];
    for (TFHppleElement *element in chapterNameNodes) {
        Image *image = [[Image alloc] init];
        [newImages addObject:image];
        image.url = [element objectForKey:@"src"];
        NSLog(@"%@", image.url);
    }
    self.imageObjects = newImages;
}
#pragma mark - Click next
- (IBAction)clickNextBtn:(id)sender {
    self.pageIndex ++;
    if(self.pageIndex <= self.imageObjects.count-1) {
        Image *image = [[Image alloc] init];
        image = [self.imageObjects objectAtIndex:self.pageIndex];
        [self.imageView setImageWithURL:[NSURL URLWithString:image.url] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    } else self.pageIndex = self.imageObjects.count - 1;
}
#pragma mark - Click preview
- (IBAction)clickPreviewBtn:(id)sender {
    self.pageIndex --;
    if(self.pageIndex >= 0) {
        Image *image = [[Image alloc] init];
        image = [self.imageObjects objectAtIndex:self.pageIndex];
        [self.imageView setImageWithURL:[NSURL URLWithString:image.url] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    } else self.pageIndex = 0;

    }
//#pragma mark - Preview
//-(void) loadChapContent:(NSString *)urlString preview:(NSString *)previewXpathQueryString {
//    NSMutableArray *newPreviews = [[NSMutableArray alloc] init];
//    NSArray *previewNodes = [[APIClient sharedInstance] loadFromUrl:urlString
//                                               withXpathQueryString:previewXpathQueryString];
//    for (TFHppleElement *element in previewNodes) {
//        if([[element objectForKey:@"id"] isEqualToString:@"prev_chap"]) {
//            Preview *preview = [[Preview alloc] init];
//            [newPreviews addObject:preview];
//            preview.url = [element objectForKey:@"href"];
//        }
//    }
//    self.previewObjects = newPreviews;
//}
//#pragma mark - Next
//-(void) loadChapContent:(NSString*)urlString next:(NSString*)nextXpathQueryString {
//    NSMutableArray *newNexts = [[NSMutableArray alloc] init];
//    NSArray *nextNodes = [[APIClient sharedInstance] loadFromUrl:urlString
//                                            withXpathQueryString:nextXpathQueryString];
//    for (TFHppleElement *element in nextNodes) {
//        if([[element objectForKey:@"id"] isEqualToString:@"next_chap"]) {
//            Next *next = [[Next alloc] init];
//            [newNexts addObject:next];
//            next.url = [element objectForKey:@"href"];
//        }
//    }
//    self.nextObjects = newNexts;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pageIndex = 0;
    Image *image = [[Image alloc] init];
    image = [self.imageObjects objectAtIndex:self.pageIndex];
    [self.imageView setImageWithURL:[NSURL URLWithString:image.url] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
