//
//  ChapContentViewController.m
//  Final Project
//
//  Created by Hung Ga 123 on 6/21/16.
//  Copyright © 2016 HungVu. All rights reserved.
//

#import "ChapContentViewController.h"
@interface ChapContentViewController ()

@end

@implementation ChapContentViewController
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

- (IBAction)clickNextBtn:(id)sender {
    if(self.nextObjects.count > 0) {
        NSString *btnXpathQueryString = @"//a[@class='btn btn-success']";
        NSString *chapContentXpathQueryString = @"//div[@class='chapter-content']";
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"%@",self.urlString);
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            ChapContentViewController *chapContentVCL = [sb instantiateViewControllerWithIdentifier:@"ChapContentViewController"];
            Next *next = [[Next alloc] init];
            next = [self.nextObjects objectAtIndex:0];
            NSString *urlString = next.url;
            chapContentVCL.urlString = urlString;
            NSLog(@"%@",chapContentVCL.urlString);
            [chapContentVCL loadChapContent:urlString chapContent:chapContentXpathQueryString];
            [chapContentVCL loadChapContent:urlString next:btnXpathQueryString];
            [chapContentVCL loadChapContent:urlString preview:btnXpathQueryString];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:chapContentVCL animated:YES completion:^{
                }];
            });
        });
    }
}

- (IBAction)clickPreviewBtn:(id)sender {
    if(self.previewObjects.count > 0) {
        NSString *btnXpathQueryString = @"//a[@class='btn btn-success']";
        NSString *chapContentXpathQueryString = @"//div[@class='chapter-content']";
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"%@",self.urlString);
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            ChapContentViewController *chapContentVCL = [sb instantiateViewControllerWithIdentifier:@"ChapContentViewController"];
            Preview *preview = [[Preview alloc] init];
            preview = [self.previewObjects objectAtIndex:0];
            NSString *urlString = preview.url;
            chapContentVCL.urlString = urlString;
            NSLog(@"%@",chapContentVCL.urlString);
            [chapContentVCL loadChapContent:urlString chapContent:chapContentXpathQueryString];
            [chapContentVCL loadChapContent:urlString preview:btnXpathQueryString];
            [chapContentVCL loadChapContent:urlString next:btnXpathQueryString];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:chapContentVCL animated:YES completion:^{
                }];
            });
        });
    }
}
-(void) loadChapContent:(NSString *)urlString preview:(NSString *)previewXpathQueryString {
    NSMutableArray *newPreviews = [[NSMutableArray alloc] init];
    NSArray *previewNodes = [[APIClient sharedInstance] loadFromUrl:urlString
                                               withXpathQueryString:previewXpathQueryString];
    for (TFHppleElement *element in previewNodes) {
        if([[element objectForKey:@"id"] isEqualToString:@"prev_chap"]) {
            Preview *preview = [[Preview alloc] init];
            [newPreviews addObject:preview];
            preview.url = [element objectForKey:@"href"];
        }
    }
    self.previewObjects = newPreviews;
}
-(void) loadChapContent:(NSString*)urlString next:(NSString*)nextXpathQueryString {
    NSMutableArray *newNexts = [[NSMutableArray alloc] init];
    NSArray *nextNodes = [[APIClient sharedInstance] loadFromUrl:urlString
                                               withXpathQueryString:nextXpathQueryString];
    for (TFHppleElement *element in nextNodes) {
        if([[element objectForKey:@"id"] isEqualToString:@"next_chap"]) {
            Next *next = [[Next alloc] init];
            [newNexts addObject:next];
            next.url = [element objectForKey:@"href"];
        }
    }
    self.nextObjects = newNexts;
}
-(void) loadChapContent:(NSString *)urlString chapContent:(NSString *)chapContentXpathQueryString {
    NSMutableArray *newChapContents = [[NSMutableArray alloc] init];
    //Chapter Name and Url
    NSArray *chapContentNodes = [[APIClient sharedInstance] loadFromUrl:urlString
                                                   withXpathQueryString:chapContentXpathQueryString];
    for (TFHppleElement *element in chapContentNodes) {
        ChapContent *chapContent = [[ChapContent alloc] init];
        [newChapContents addObject:chapContent];
        chapContent.textContent = @"";
        for(TFHppleElement *child in element.children) {
            if(child.content != nil) {
                chapContent.textContent = [chapContent.textContent stringByAppendingString:child.content];
            } else {
                if([child.tagName isEqualToString:@"span"] || [child.tagName isEqualToString:@"p"] || [child.tagName isEqualToString:@"b"] || [child.tagName isEqualToString:@"i"]) {
                    for (TFHppleElement *subChild in child.children) {
                        if(subChild.content != nil) {
                            chapContent.textContent = [chapContent.textContent stringByAppendingString:subChild.content];
                        } else {
                            if([subChild.tagName isEqualToString:@"b"] || [subChild.tagName isEqualToString:@"i"] ||[subChild.tagName isEqualToString:@"p"] || [subChild.tagName isEqualToString:@"span"]){
                                for (TFHppleElement *superSubChild in subChild.children) {
                                    if(superSubChild.content != nil) {
                                        chapContent.textContent = [chapContent.textContent stringByAppendingString:superSubChild.content];
                                    } else {
                                        if([subChild.tagName isEqualToString:@"p"] || [superSubChild.tagName isEqualToString:@"b"] || [superSubChild.tagName isEqualToString:@"i"]|| [superSubChild.tagName isEqualToString:@"span"]) {
                                            if(superSubChild.firstChild.content != nil) {
                                                chapContent.textContent = [chapContent.textContent stringByAppendingString:superSubChild.firstChild.content];
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    self.chapContentObjects = newChapContents;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(self.chapContentObjects.count > 0) {
        ChapContent *chapContent = [[ChapContent alloc] init];
        chapContent = [self.chapContentObjects objectAtIndex:0];
        self.lblChapContent.text = chapContent.textContent;
    }
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
