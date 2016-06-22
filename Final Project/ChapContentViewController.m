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
    CategoryViewController *categoryVCL = [sb instantiateViewControllerWithIdentifier:@"2"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:categoryVCL animated:YES completion:^{
            }];
        });
    });
}

-(void) loadChapContent:(NSString *)UrlString chapContent:(NSString *)chapContentXpathQueryString {
    NSMutableArray *newChapContents = [[NSMutableArray alloc] init];
    //Chapter Name and Url
    NSArray *chapContentNodes = [[APIClient sharedInstance] loadFromUrl:UrlString
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
        NSLog(@"%@",chapContent.textContent);
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
