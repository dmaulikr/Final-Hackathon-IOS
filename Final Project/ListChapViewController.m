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
-(void) loadListChap:(NSString*)urlString chapterName:(NSString *)chapterNameXpathQueryString {
    NSMutableArray *newChaps = [[NSMutableArray alloc] init];
    //Chapter Name and Url
    NSArray *chapterNameNodes = [[APIClient sharedInstance] loadFromUrl:urlString
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
-(void) loadSummary:(NSString*)UrlString summaryContent:(NSString *)summaryContentXpathQueryString rating:(NSString *)ratingXpathQueryString {
    NSMutableArray *newSummarys = [[NSMutableArray alloc] init];
    //Summary
    NSArray *summaryContentNodes = [[APIClient sharedInstance] loadFromUrl:UrlString
                                                      withXpathQueryString:summaryContentXpathQueryString];
    if(summaryContentNodes.count == 0) {
        NSString *ratingXpathQueryString2 = @"//span[@itemprop='ratingValue']";
        NSString *summaryContentXpathQueryString2 = @"//div[@class='desc-text desc-text-full']";
        [self loadSummary:self.urlString summaryContent:summaryContentXpathQueryString2 rating:ratingXpathQueryString2];
    } else {
        for (TFHppleElement *element in summaryContentNodes) {
            SummaryContent *summaryContent = [[SummaryContent alloc] init];
            summaryContent.textContent = @"";
            for (TFHppleElement *child in element.children) {
                if(child.content != nil) {
                    summaryContent.textContent = [summaryContent.textContent stringByAppendingString:child.content];
                } else {
                    if([child.tagName isEqualToString:@"p"] || [child.tagName isEqualToString:@"span"] || [child.tagName isEqualToString:@"b"] || [child.tagName isEqualToString:@"i"]) {
                        for (TFHppleElement *subChild in child.children) {
                            if(subChild.content != nil) {
                                summaryContent.textContent = [summaryContent.textContent stringByAppendingString:subChild.content];
                            } else {
                                if([subChild.tagName isEqualToString:@"b"] || [subChild.tagName isEqualToString:@"i"]|| [subChild.tagName isEqualToString:@"span"] || [subChild.tagName isEqualToString:@"p"]) {
                                    for (TFHppleElement *superSubChild in subChild.children) {
                                        if(superSubChild.content != nil) {
                                            summaryContent.textContent = [summaryContent.textContent stringByAppendingString:superSubChild.content];
                                        } else {
                                            if([subChild.tagName isEqualToString:@"p"] || [superSubChild.tagName isEqualToString:@"b"] || [superSubChild.tagName isEqualToString:@"i"]|| [superSubChild.tagName isEqualToString:@"span"]) {
                                                if(superSubChild.firstChild.content != nil) {
                                                    summaryContent.textContent = [summaryContent.textContent stringByAppendingString:superSubChild.firstChild.content];
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
            Summary *summary = [[Summary alloc] init];
            [newSummarys addObject:summary];
            summary.summaryContent = summaryContent;
        }
        //Rating
        NSArray *ratingContentNodes = [[APIClient sharedInstance] loadFromUrl:UrlString
                                                         withXpathQueryString:ratingXpathQueryString];
        for (TFHppleElement *element in ratingContentNodes) {
            Rating *rating = [[Rating alloc] init];
            rating.title = element.firstChild.content;
            Summary *summary = [[Summary alloc] init];
            if(newSummarys.count > 0) {
                summary = [newSummarys objectAtIndex:0];
                summary.rating = rating;
            } else {
                [newSummarys addObject:summary];
                summary = [newSummarys objectAtIndex:0];
                summary.rating = rating;
            }
        }
        self.summaryObjects = newSummarys;
        [self viewDidLoad];
    }
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
    ChapContentViewController *chapContentVCL = [sb instantiateViewControllerWithIdentifier:@"ChapContentViewController"];
    ChapDetail *chapOfThisCell = [self.chapDetailObjects objectAtIndex:indexPath.row];
    NSString *urlString = chapOfThisCell.chapterName.url;
    NSString *btnXpathQueryString = @"//a[@class='btn btn-success']";
    NSString *chapContentXpathQueryString = @"//div[@class='chapter-content']";
    chapContentVCL.urlString = urlString;
    [chapContentVCL loadChapContent:urlString chapContent:chapContentXpathQueryString];
    [chapContentVCL loadChapContent:urlString next:btnXpathQueryString];
    [chapContentVCL loadChapContent:urlString preview:btnXpathQueryString];
    //[self.navigationController pushViewController:chapContentVCL animated:YES];
    [self presentViewController:chapContentVCL animated:YES completion:^{
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [[UIView alloc] init];
    Summary *summary = [[Summary alloc] init];
    summary = [self.summaryObjects objectAtIndex:0];
    self.lblSummaryContent.text = summary.summaryContent.textContent;
    self.lblRating.text = summary.rating.title;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
