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
    //Stt
    NSString *chapIDXpathQueryString = @"//span[@class='spanstt']";
    NSArray *chapIDNodes = [[APIClient sharedInstance] loadFromUrl:chapUrlString
                                                 withXpathQueryString:chapIDXpathQueryString];
    for (TFHppleElement *element in chapIDNodes) {
        ChapID *chapID = [[ChapID alloc] init];
        chapID.title = [[element  firstChild] content];
        ChapDetail *chapDetail = [[ChapDetail alloc] init];
        [newChaps addObject:chapDetail];
        chapDetail.chapID = chapID;
    }
    //Chapter
    NSString *chapterXpathQueryString = @"//span[@class='spanchapter']";
    NSArray *chapterNodes = [[APIClient sharedInstance] loadFromUrl:chapUrlString
                                                withXpathQueryString:chapterXpathQueryString];
    int i=0;
    for (TFHppleElement *element in chapterNodes) {
        Chapter *chapter = [[Chapter alloc] init];
        chapter.title = [[element  firstChild] content];
        ChapDetail *chapDetail = [[ChapDetail alloc] init];
        chapDetail = [newChaps objectAtIndex:i];
        chapDetail.chapter = chapter;
        i++;
    }
    i = 0;
    //Chapter Name and link
    NSString *chapterNameXpathQueryString = @"//span[@class='spanchaptername nobook']/a";
    NSArray *chapterNameNodes = [[APIClient sharedInstance] loadFromUrl:chapUrlString
                                               withXpathQueryString:chapterNameXpathQueryString];
    for (TFHppleElement *element in chapterNameNodes) {
        ChapterName *chapterName = [[ChapterName alloc] init];
        chapterName.title = [[element firstChild] content];
        chapterName.url = [element objectForKey:@"href"];
        ChapDetail *chapDetail = [[ChapDetail alloc] init];
        chapDetail = [newChaps objectAtIndex:i+1];
        chapDetail.chapterName = chapterName;
        i++;
    }
    ChapterName *chapterName = [[ChapterName alloc] init];
    chapterName.title = @"Ten Chuong";
    chapterName.url = @"Chap url";
    ChapDetail *chapDetail = [[ChapDetail alloc] init];
    chapDetail = [newChaps objectAtIndex:0];
    chapDetail.chapterName = chapterName;
    i = 0;
    //DateUpdate
    NSString *dateUpdateXpathQueryString = @"//span[@class='spandataup']";
    NSArray *dateUpdateNodes = [[APIClient sharedInstance] loadFromUrl:chapUrlString
                                                   withXpathQueryString:dateUpdateXpathQueryString];
    for (TFHppleElement *element in dateUpdateNodes) {
        DateUpdate *dateUpdate = [[DateUpdate alloc] init];
        dateUpdate.title = [[element firstChild] content];
        ChapDetail *chapDetail = [[ChapDetail alloc] init];
        chapDetail = [newChaps objectAtIndex:i];
        chapDetail.dateUpdate = dateUpdate;
        i++;
    }
    i = 0;
    self.chapDetailObjects = newChaps;
    [self.tableView reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chapDetailObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell3 *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell3" forIndexPath:indexPath];
    ChapDetail  *chapDetailOfThisCell = [self.chapDetailObjects objectAtIndex:indexPath.row];
    cell.lblStt.text = chapDetailOfThisCell.chapID.title;
    cell.lblChapter.text = chapDetailOfThisCell.chapter.title;
    cell.lblLink.text = chapDetailOfThisCell.chapterName.url;
    cell.lblChapterName.text = chapDetailOfThisCell.chapterName.title;
    cell.lblDateUpdate.text = chapDetailOfThisCell.dateUpdate.title;
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
