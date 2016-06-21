//
//  ViewController2.m
//  Final Project
//
//  Created by Hung Ga 123 on 6/20/16.
//  Copyright © 2016 HungVu. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2
-(void) loadCategory:(NSString*)categoryUrlString withXpathQueryString:(NSString*)categorysXpathQueryString {
     NSMutableArray *newCategorys = [[NSMutableArray alloc] init];
    NSArray *categoryNodes = [[APIClient sharedInstance] loadFromUrl:categoryUrlString
                                                withXpathQueryString:categorysXpathQueryString];
    for (TFHppleElement *element in categoryNodes) {
        Category *category = [[Category alloc] init];
        [newCategorys addObject:category];
        for (TFHppleElement *child in element.children) {
            category.title = [child content];
        }
        category.url = [element objectForKey:@"href"];
    }
    self.categoryObjects = newCategorys;
    [self.tableView reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categoryObjects.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Category  *categoryOfThisCell = [self.categoryObjects objectAtIndex:indexPath.row];
    cell.lblTitle.text = categoryOfThisCell.title;
    cell.lblLink.text = categoryOfThisCell.url;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.vcl3 = [sb instantiateViewControllerWithIdentifier:@"3"];
    Category  *categoryOfThisCell = [self.categoryObjects objectAtIndex:indexPath.row];
    [self.vcl3 loadListStorys:categoryOfThisCell.url];
    [self.navigationController pushViewController:_vcl3 animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [[UIView alloc] init];
    NSString *categoryUrlString = @"http://truyenfull.vn/";
    NSString *categorysXpathQueryString = @"//div[@class='col-xs-6']/a";
    [self loadCategory:categoryUrlString withXpathQueryString:categorysXpathQueryString];
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
