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
    NSString *imgXpathQueryString = @"//ul[@class='list_ct']/li";
    NSArray *storyNodes = [[APIClient sharedInstance] loadFromUrl:storyUrlString
                                             withXpathQueryString:imgXpathQueryString];
    NSMutableArray *newStorys = [[NSMutableArray alloc] init];
    for (TFHppleElement *element in storyNodes) {
        StoryIntroduce *storyIntro = [[StoryIntroduce alloc] init];
        [newStorys addObject:storyIntro];
        NSLog(@"%@", [[[element  firstChild] firstChild] objectForKey:@"title"]);
        NSLog(@"%@", [[[element  firstChild] firstChild] objectForKey:@"href"]);
        storyIntro.storyName.title = [[[element  firstChild] firstChild] objectForKey:@"title"];
        storyIntro.storyName.url = [[[element  firstChild] firstChild] objectForKey:@"href"];
        for (TFHppleElement *child in element.children) {
            if([child.tagName isEqualToString:@"h3"]) {
                
            }
        }
    }
    self.storyObjects = newStorys;
    [self.tableView reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.storyObjects.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell2 *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell2" forIndexPath:indexPath];
    StoryIntroduce  *storyOfThisCell = [self.storyObjects objectAtIndex:indexPath.row];
    cell.lblStoryName.text = storyOfThisCell.storyName.title;
    cell.lblCurrentChap.text = storyOfThisCell.storyName.url;
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadListStorys:self.clickedLink];
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
