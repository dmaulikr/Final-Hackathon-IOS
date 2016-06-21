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
-(void) loadChapContent:(NSString *)UrlString {
    NSMutableArray *newChapContents = [[NSMutableArray alloc] init];
    //Chapter Name and Url
    NSString *chapContentXpathQueryString = @"//div[@class='chapter-content']";
    NSArray *chapContentNodes = [[APIClient sharedInstance] loadFromUrl:UrlString
                                                   withXpathQueryString:chapContentXpathQueryString];
    for (TFHppleElement *element in chapContentNodes) {
        ChapContent *chapContent = [[ChapContent alloc] init];
        [newChapContents addObject:chapContent];
        chapContent.textContent = @"";
        for(TFHppleElement *child in element.children) {
            if(child.content != nil) {
                chapContent.textContent = [chapContent.textContent stringByAppendingString:child.content];
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
