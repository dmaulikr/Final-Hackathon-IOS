//
//  ViewController2.m
//  Final Project
//
//  Created by Hung Ga 123 on 6/20/16.
//  Copyright © 2016 HungVu. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()
@end

@implementation CategoryViewController
-(void) loadCategory:(NSString*)categoryUrlString withXpathQueryString:(NSString*)categorysXpathQueryString {
    NSMutableArray *newCategorys = [[NSMutableArray alloc] init];
    //Category list
    NSArray *categoryNodes = [[APIClient sharedInstance] loadFromUrl:categoryUrlString
                                                withXpathQueryString:categorysXpathQueryString];
    for (TFHppleElement *element in categoryNodes) {
        for (TFHppleElement *child in element.children) {
            if ([child.tagName isEqualToString:@"a"]) {
                xCategory *category = [[xCategory alloc] init];
                [newCategorys addObject:category];
                category.url = [child objectForKey:@"href"];
                category.title = [child.firstChild content];
                for(TFHppleElement *subChild in child.children) {
                    if([subChild.tagName isEqualToString:@"strong"]) {
                        category.title = [subChild.firstChild content];
                    }
                }
            }
        }
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
    xCategory  *categoryOfThisCell = [self.categoryObjects objectAtIndex:indexPath.row];
    cell.lblTitle.text = categoryOfThisCell.title;
    cell.lblLink.text = categoryOfThisCell.url;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ListStoryViewController *listStoryVCL = [sb instantiateViewControllerWithIdentifier:@"ListStoryViewController"];
    [self presentViewController:listStoryVCL animated:YES completion:^{
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        xCategory  *categoryOfThisCell = [self.categoryObjects objectAtIndex:indexPath.row];
        NSString *urlString = categoryOfThisCell.url;
        NSString *storyNameXpathQueryString = @"//h3[@class='nowrap']/a";
        NSString *totalViewXpathQueryString = @"//div[@class='wrap_update tab_anh_dep danh_sach']/div/span";
        NSString *coverXpathQueryString = @"//div[@class='wrap_update tab_anh_dep danh_sach']/div/a";
        NSString *currentChapXpathQueryString = @"//div[@class='wrap_update tab_anh_dep danh_sach']/div/a";
        NSString *categorysXpathQueryString = @"//div[@class='item2_theloai']";
        
        NSString *currentPageXpathQueryString = @"//span[@class='current']";
        NSString *previewPageXpathQueryString = @"//a[@class='previouspostslink']";
        NSString *nextPageXpathQueryString = @"//a[@class='nextpostslink']";
        listStoryVCL.urlString = urlString;
        [listStoryVCL loadListStorys:(NSString*)urlString storyName:(NSString*)storyNameXpathQueryString];
        [listStoryVCL loadListStorys:(NSString*)urlString currentChap:(NSString*)currentChapXpathQueryString];
        [listStoryVCL loadListStorys:(NSString*)urlString categorys:(NSString*)categorysXpathQueryString];
        [listStoryVCL loadListStorys:(NSString*)urlString cover:(NSString*)coverXpathQueryString];
        [listStoryVCL loadListStorys:(NSString*)urlString currentPage:(NSString*)currentPageXpathQueryString];
        [listStoryVCL loadListStorys:(NSString*)urlString previewPage:(NSString*)previewPageXpathQueryString];
        [listStoryVCL loadListStorys:(NSString*)urlString nextPage:(NSString*)nextPageXpathQueryString];
        [listStoryVCL loadListStorys:(NSString*)urlString totalView:(NSString*)totalViewXpathQueryString];
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView transitionWithView: listStoryVCL.tableView
                              duration: 0.5f
                               options: UIViewAnimationOptionTransitionCurlUp
                            animations: ^(void)
             {
                 [listStoryVCL.tableView reloadData];
             }
                            completion: nil];
        });
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    reach.reachableBlock = ^(Reachability*reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"REACHABLE!");
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSString *categoryUrlString = @"http://mangak.info/";
                NSString *categorysXpathQueryString = @"//table[@class='theloai']/tbody/tr/td";
                [self loadCategory:categoryUrlString withXpathQueryString:categorysXpathQueryString];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIView transitionWithView: self.tableView
                                      duration: 0.5f
                                       options: UIViewAnimationOptionTransitionCurlDown
                                    animations: ^(void)
                     {
                         [self.tableView reloadData];
                     }
                                    completion: nil];
                });
            });
            
        });
    };
    
    reach.unreachableBlock = ^(Reachability*reach)
    {
        NSLog(@"UNREACHABLE!");
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"FBI Warning"
                                     message:@"Please checking for your network !"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Yes"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                    }];
        
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"No, thanks"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                   }];
        [alert addAction:yesButton];
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    };
    [reach startNotifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
