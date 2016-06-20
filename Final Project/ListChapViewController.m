//
//  ListChapViewController.m
//  Final Project
//
//  Created by Hung Ga 123 on 6/20/16.
//  Copyright © 2016 HungVu. All rights reserved.
//

#import "ListChapViewController.h"

@interface ListChapViewController ()

@end

@implementation ListChapViewController
-(void) loadListChap:(NSString*)chapUrlString {
    NSMutableArray *newChaps = [[NSMutableArray alloc] init];
    //Chapter Name and Url
    NSString *chapterNameXpathQueryString = @"//ul[@class='list-chapter']/li/a";
    NSArray *chapterNameNodes = [[APIClient sharedInstance] loadFromUrl:chapUrlString
                                                   withXpathQueryString:chapterNameXpathQueryString];
    for (TFHppleElement *element in chapterNameNodes) {
        ChapterName *chapterName = [[ChapterName alloc] init];
        chapterName.title = [element objectForKey:@"title"];
        chapterName.url = [element objectForKey:@"href"];
        ChapDetail *chapDetail = [[ChapDetail alloc] init];
        [newChaps addObject:chapDetail];
        chapDetail.chapterName = chapterName;
    }
    self.chapDetailObjects = newChaps;
    [self.tableView reloadData];
}
-(void) loadSummary:(NSString*)chapUrlString {
    NSMutableArray *newSummarys = [[NSMutableArray alloc] init];
    //Summary
    NSString *summaryContentXpathQueryString = @"//div[@class='desc-text']";
    NSArray *summaryContentNodes = [[APIClient sharedInstance] loadFromUrl:chapUrlString
                                                      withXpathQueryString:summaryContentXpathQueryString];
    for (TFHppleElement *element in summaryContentNodes) {
        SummaryContent *summaryContent = [[SummaryContent alloc] init];
        summaryContent.textContent = @"";
        for (TFHppleElement *child in element.children) {
            if(child.content != nil) {
                summaryContent.textContent = [summaryContent.textContent stringByAppendingString:child.content];
            } else {
                summaryContent.textContent = [summaryContent.textContent stringByAppendingString:@" "];
            }
        }
        NSLog(@"%@",summaryContent.textContent);
        Summary *summary = [[Summary alloc] init];
        [newSummarys addObject:summary];
        summary.summaryContent = summaryContent;
    }
    self.summaryObjects = newSummarys;
    [self viewDidLoad];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chapDetailObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell3 *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell3" forIndexPath:indexPath];
    ChapDetail  *chapDetailOfThisCell = [self.chapDetailObjects objectAtIndex:indexPath.row];
    cell.lblLink.text = chapDetailOfThisCell.chapterName.url;
    cell.lblChapterName.text = chapDetailOfThisCell.chapterName.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    // self.listChapVCL = [sb instantiateViewControllerWithIdentifier:@"4"];
    ChapDetail *chapDetailOfThisCell = [self.chapDetailObjects objectAtIndex:indexPath.row];
    //[self.listChapVCL loadListChap:chapDetailOfThisCell.storyName.url];
    // [self.navigationController pushViewController:self.listChapVCL animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(self.summaryObjects.count>0) {
        Summary *summary = [[Summary alloc] init];
        summary = [self.summaryObjects objectAtIndex:0];
        self.lblSummaryContent.text = summary.summaryContent.textContent;
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
