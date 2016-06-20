//
//  ViewController3.m
//  Final Project
//
//  Created by Hung Ga 123 on 6/20/16.
//  Copyright © 2016 HungVu. All rights reserved.
//

#import "ViewController3.h"

@interface ViewController3 ()

@end

@implementation ViewController3
-(void) loadListStorys:(NSString*)storyUrlString {
    NSMutableArray *newStorys = [[NSMutableArray alloc] init];
//Story'name and link
    NSString *storyNameXpathQueryString = @"//h3[@class='prodTitle']";
    NSArray *storyNameNodes = [[APIClient sharedInstance] loadFromUrl:storyUrlString
                                             withXpathQueryString:storyNameXpathQueryString];
    for (TFHppleElement *element in storyNameNodes) {
        StoryName *storyName = [[StoryName alloc] init];
        storyName.title = [[element  firstChild] objectForKey:@"title"];
        storyName.url = [[element  firstChild] objectForKey:@"href"];
        StoryIntroduce *storyIntro = [[StoryIntroduce alloc] init];
        [newStorys addObject:storyIntro];
        storyIntro.storyName = storyName;
    }
//Current chap
    NSString *currentChapXpathQueryString = @"//div[@class='bgprod']";
    NSArray *currentChapNodes = [[APIClient sharedInstance] loadFromUrl:storyUrlString
                                             withXpathQueryString:currentChapXpathQueryString];
    int i=0;
    for (TFHppleElement *element in currentChapNodes) {
        CurrentChap *currentChap = [[CurrentChap alloc] init];
        currentChap.title = [element.firstChild content];
        StoryIntroduce *storyIntro = [[StoryIntroduce alloc] init];
        storyIntro = [newStorys objectAtIndex:i];
        storyIntro.currentChap = currentChap;
        i++;
    }
    i = 0;
//Cover
    NSString *coverXpathQueryString = @"//div[@class='list_img']/a/img";
    NSArray *coverNodes = [[APIClient sharedInstance] loadFromUrl:storyUrlString
                                                   withXpathQueryString:coverXpathQueryString];
    for (TFHppleElement *element in coverNodes) {
        Cover *cover = [[Cover alloc] init];
        cover.url = [element objectForKey:@"src"];
        StoryIntroduce *storyIntro = [[StoryIntroduce alloc] init];
        storyIntro = [newStorys objectAtIndex:i];
        storyIntro.cover = cover;
        NSLog(@"%@",[element objectForKey:@"src"]);
        i++;
    }
    self.storyObjects = newStorys;
    [self.tableView reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.storyObjects.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell2 *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell2" forIndexPath:indexPath];
    StoryIntroduce  *storyOfThisCell = [self.storyObjects objectAtIndex:indexPath.row];
    cell.lblStoryName.text = storyOfThisCell.storyName.title;
    cell.lblLink.text = storyOfThisCell.storyName.url;
    cell.lblCurrentChap.text = storyOfThisCell.currentChap.title;
    [cell.coverImgView sd_setImageWithURL:[NSURL URLWithString:storyOfThisCell.cover.url]];
    return cell;
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
