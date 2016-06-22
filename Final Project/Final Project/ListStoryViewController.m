//
//  ViewController3.m
//  Final Project
//
//  Created by Hung Ga 123 on 6/20/16.
//  Copyright © 2016 HungVu. All rights reserved.
//

#import "ListStoryViewController.h"

@interface ListStoryViewController ()

@end

@implementation ListStoryViewController

-(void) loadListStorys:(NSString*)urlString storyName:(NSString *)storyNameXpathQueryString currentChap:(NSString *)currentChapXpathQueryString author:(NSString *)authorXpathQueryString cover:(NSString *)coverXpathQueryString {
    NSMutableArray *newStorys = [[NSMutableArray alloc] init];
    //Story'name and Url
    NSArray *storyNameNodes = [[APIClient sharedInstance] loadFromUrl:urlString
                                                 withXpathQueryString:storyNameXpathQueryString];
    for (TFHppleElement *element in storyNameNodes) {
        StoryName *storyName = [[StoryName alloc] init];
        storyName.title = [element.firstChild content];
        storyName.url = [element objectForKey:@"href"];
        StoryIntroduce *storyIntro = [[StoryIntroduce alloc] init];
        [newStorys addObject:storyIntro];
        storyIntro.storyName = storyName;
    }
    //Current chap
    NSArray *currentChapNodes = [[APIClient sharedInstance] loadFromUrl:urlString
                                                   withXpathQueryString:currentChapXpathQueryString];
    int i=0;
    for (TFHppleElement *element in currentChapNodes) {
        CurrentChap *currentChap = [[CurrentChap alloc] init];
        currentChap.title = @"";
        for (TFHppleElement *child in element.children) {
            if([child.tagName isEqualToString:@"span"]) continue;
            else {
                currentChap.title = [currentChap.title stringByAppendingString:child.content];
            }
        }
        StoryIntroduce *storyIntro = [[StoryIntroduce alloc] init];
        storyIntro = [newStorys objectAtIndex:i];
        storyIntro.currentChap = currentChap;
        i++;
    }
    i = 0;
    //Author
    NSArray *authorNodes = [[APIClient sharedInstance] loadFromUrl:urlString
                                              withXpathQueryString:authorXpathQueryString];
    for (TFHppleElement *element in authorNodes) {
        Author *author = [[Author alloc] init];
        for (TFHppleElement *child in element.children) {
            if([child.tagName isEqualToString:@"span"]) continue;
            else {
                author.title = [child content];
            }
        }
        StoryIntroduce *storyIntro = [[StoryIntroduce alloc] init];
        storyIntro = [newStorys objectAtIndex:i];
        storyIntro.author = author;
        i++;
    }
    i = 0;
    //Cover
    NSArray *coverNodes = [[APIClient sharedInstance] loadFromUrl:urlString
                                             withXpathQueryString:coverXpathQueryString];
    for (TFHppleElement *element in coverNodes) {
        Cover *cover = [[Cover alloc] init];
        cover.url = [[element.firstChild attributes] objectForKey:@"data-image"];
        StoryIntroduce *storyIntro = [[StoryIntroduce alloc] init];
        storyIntro = [newStorys objectAtIndex:i];
        storyIntro.cover = cover;
        i++;
    }
    i = 0;
    self.storyObjects = newStorys;
    [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.storyObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell2 *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell2" forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.coverImgView.image = nil;
    StoryIntroduce  *storyOfThisCell = [self.storyObjects objectAtIndex:indexPath.row];
    
    cell.lblStoryName.text = storyOfThisCell.storyName.title;
    cell.lblLink.text = storyOfThisCell.storyName.url;
    cell.lblCurrentChap.text = storyOfThisCell.currentChap.title;
    cell.lblAuthor.text = storyOfThisCell.author.title;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cell.coverImgView sd_setImageWithURL:[NSURL URLWithString:storyOfThisCell.cover.url]];
        UIImage *img = cell.coverImgView.image;
        dispatch_async(dispatch_get_main_queue(), ^{
            if(cell.indexPath.row == indexPath.row) {
                cell.coverImgView.image = img;
            }
        });
    });
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ListChapViewController *listChapVCL = [sb instantiateViewControllerWithIdentifier:@"ListChapViewController"];
    StoryIntroduce *storyOfThisCell = [self.storyObjects objectAtIndex:indexPath.row];
    NSString *urlString = storyOfThisCell.storyName.url;
    NSString *summaryContentXpathQueryString = @"//div[@class='desc-text']";
    NSString *ratingXpathQueryString = @"//span[@itemprop='ratingValue']";
    NSString *chapterNameXpathQueryString = @"//ul[@class='list-chapter']/li/a";
    listChapVCL.urlString = urlString;
    [listChapVCL loadListChap:urlString chapterName:chapterNameXpathQueryString];
    [listChapVCL loadSummary:urlString summaryContent:summaryContentXpathQueryString rating:ratingXpathQueryString];
    //[self.navigationController pushViewController:listChapVCL animated:YES];
    [self presentViewController:listChapVCL animated:YES completion:^{
    }];
}
-(NSString*) param:(int) x {
    NSString *str = [self.urlString stringByAppendingString:[NSString stringWithFormat:@"trang-%d/",x]];
    return str;
}
- (IBAction)clickPreviewPage:(id)sender {
    
}

- (IBAction)clickNextPage:(id)sender {
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [[UIView alloc] init];
    NSLog(@"%@",[self param:5]);
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
