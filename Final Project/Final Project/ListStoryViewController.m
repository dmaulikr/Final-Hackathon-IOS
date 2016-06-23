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
#pragma mark - Story name
-(void) loadListStorys:(NSString*)urlString storyName:(NSString*)storyNameXpathQueryString {
    
    NSMutableArray *newStoryNames = [[NSMutableArray alloc] init];
    NSArray *storyNameNodes = [[APIClient sharedInstance] loadFromUrl:urlString
                                                 withXpathQueryString:storyNameXpathQueryString];
    for (TFHppleElement *element in storyNameNodes) {
        StoryName *storyName = [[StoryName alloc] init];
        storyName.title = [element.firstChild content];
        storyName.url = [element objectForKey:@"href"];
        [newStoryNames addObject:storyName];
    }
    self.storyNameObjects = newStoryNames;
}
#pragma mark - Total view
-(void) loadListStorys:(NSString*)urlString totalView:(NSString*)totalViewXpathQueryString {
    NSMutableArray *newTotalViews = [[NSMutableArray alloc] init];
    NSArray *totalViewNodes = [[APIClient sharedInstance] loadFromUrl:urlString
                                                 withXpathQueryString:totalViewXpathQueryString];
    for (TFHppleElement *element in totalViewNodes) {
        TotalView *totalView = [[TotalView alloc] init];
        [newTotalViews addObject:totalView];
        totalView.title = [element.firstChild content];
    }
    self.totalViewObjects = newTotalViews;
}
#pragma mark - Cover image
-(void) loadListStorys:(NSString*)urlString cover:(NSString*)coverXpathQueryString {
    NSMutableArray *newCovers = [[NSMutableArray alloc] init];
    NSArray *coverNodes = [[APIClient sharedInstance] loadFromUrl:urlString
                                             withXpathQueryString:coverXpathQueryString];
    for (TFHppleElement *element in coverNodes) {
        if([[element objectForKey:@"rel"] isEqualToString:@"nofollow"]) {
            Cover *cover = [[Cover alloc] init];
            [newCovers addObject:cover];
            cover.url = [element.firstChild objectForKey:@"src"];
        }
    }
    self.coverObjects = newCovers;
}
#pragma mark - CurrentChap
-(void) loadListStorys:(NSString*)urlString currentChap:(NSString*)currentChapXpathQueryString {
    NSMutableArray *newCurrentChaps = [[NSMutableArray alloc] init];
    NSArray *currentChapNodes = [[APIClient sharedInstance] loadFromUrl:urlString
                                                   withXpathQueryString:currentChapXpathQueryString];
    for (TFHppleElement *element in currentChapNodes) {
        if([[element objectForKey:@"class"] isEqualToString:@"chapter"]) {
            CurrentChap *currentChap = [[CurrentChap alloc] init];
            [newCurrentChaps addObject:currentChap];
            currentChap.title = [element.firstChild content];
        }
    }
    self.currentChapObjects = newCurrentChaps;
}
#pragma mark - Categorys
-(void) loadListStorys:(NSString*)urlString categorys:(NSString*)categorysXpathQueryString {
    NSMutableArray *newCategoryss = [[NSMutableArray alloc] init];
    NSArray *categorysNodes = [[APIClient sharedInstance] loadFromUrl:urlString
                                                 withXpathQueryString:categorysXpathQueryString];
    for (TFHppleElement *element in categorysNodes) {
        Categorys *categorys = [[Categorys alloc] init];
        [newCategoryss addObject:categorys];
        categorys.title = @"";
        for(TFHppleElement *child in element.children) {
            if(child.firstChild.content != nil) {
                categorys.title = [categorys.title stringByAppendingString:[NSString stringWithFormat:@"%@ ",child.firstChild.content]];
            }
        }
    }
    self.categorysObjects = newCategoryss;
}
#pragma mark - Current page
-(void) loadListStorys:(NSString*)urlString currentPage:(NSString*)currentPageXpathQueryString {
    NSMutableArray *newCurrentPages = [[NSMutableArray alloc] init];
    NSArray *currentPageNodes = [[APIClient sharedInstance] loadFromUrl:urlString
                                                   withXpathQueryString:currentPageXpathQueryString];
    for (TFHppleElement *element in currentPageNodes) {
        CurrentPage *currentPage = [[CurrentPage alloc] init];
        [newCurrentPages addObject:currentPage];
        currentPage.title = [element.firstChild content];
    }
    self.currentPageObjects = newCurrentPages;
}
#pragma mark - Preview page
-(void) loadListStorys:(NSString*)urlString previewPage:(NSString*)previewPageXpathQueryString {
    NSMutableArray *newPreviewPages = [[NSMutableArray alloc] init];
    NSArray *previewPageNodes = [[APIClient sharedInstance] loadFromUrl:urlString
                                                   withXpathQueryString:previewPageXpathQueryString];
    for (TFHppleElement *element in previewPageNodes) {
        PreviewPage *previewPage = [[PreviewPage alloc] init];
        [newPreviewPages addObject:previewPage];
        previewPage.url = [element.firstChild content];
    }
    self.previewPageObjects = newPreviewPages;
}
#pragma mark - Next page
-(void) loadListStorys:(NSString*)urlString nextPage:(NSString*)nextPageXpathQueryString {
    NSMutableArray *newNextPages = [[NSMutableArray alloc] init];
    NSArray *nextPageNodes = [[APIClient sharedInstance] loadFromUrl:urlString
                                                withXpathQueryString:nextPageXpathQueryString];
    for (TFHppleElement *element in nextPageNodes) {
        NextPage *nextPage = [[NextPage alloc] init];
        [newNextPages addObject:nextPage];
        nextPage.url = [element.firstChild content];
    }
    self.nextPageObjects = newNextPages;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.storyNameObjects.count;
}
#pragma mark - cellForRowAtIndexPath
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell2 *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell2" forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.coverImgView.image = nil;
    StoryName  *storyNameOfThisCell = [self.storyNameObjects objectAtIndex:indexPath.row];
    TotalView *totalViewOfThisCell = [self.totalViewObjects objectAtIndex:indexPath.row];
    Cover *coverOfThisCell = [self.coverObjects objectAtIndex:indexPath.row];
    CurrentChap *currentChapOfThisCell = [self.currentChapObjects objectAtIndex:indexPath.row];
    Categorys *categorysOfThisCell = [self.categorysObjects objectAtIndex:indexPath.row];
    [cell.coverImgView setImageWithURL:[NSURL URLWithString:coverOfThisCell.url] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIImage *img = cell.coverImgView.image;
    if(cell.indexPath.row == indexPath.row) {
        cell.coverImgView.image = img;
        cell.lblStoryName.text = storyNameOfThisCell.title;
        cell.lblTotalView.text = totalViewOfThisCell.title;
        cell.lblCurrentChap.text = currentChapOfThisCell.title;
        cell.lblLink.text = storyNameOfThisCell.url;
        cell.lblCategorys.text = categorysOfThisCell.title;
    }
    return cell;
}
#pragma mark - didSelectRowAtIndexPath
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ListChapViewController *listChapVCL = [sb instantiateViewControllerWithIdentifier:@"ListChapViewController"];
    [self presentViewController:listChapVCL animated:YES completion:^{
    }];
    UILabel *alret = [[UILabel alloc] initWithFrame:CGRectMake(listChapVCL.view.frame.size.width/2, listChapVCL.view.frame.size.height/2, 200, 100)];
    alret.backgroundColor = [UIColor yellowColor];
    alret.text = @"Loading please wait !";
    [listChapVCL.view addSubview:alret];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        StoryName  *storyNameOfThisCell = [self.storyNameObjects objectAtIndex:indexPath.row];
        NSString *urlString = storyNameOfThisCell.url;
        NSString *summaryContentXpathQueryString = @"//div[@class='entry-content']";
        NSString *chapterNameXpathQueryString = @"//div[@class='row']";
        listChapVCL.urlString = urlString;
        [listChapVCL loadListChap:urlString chapterName:chapterNameXpathQueryString];
        [listChapVCL loadListChap:urlString dateUpdate:chapterNameXpathQueryString];
        [listChapVCL loadListChap:urlString summaryContent:summaryContentXpathQueryString];
        dispatch_async(dispatch_get_main_queue(), ^{
            [alret setHidden:YES];
            [UIView transitionWithView: listChapVCL.tableView
                              duration: 0.5f
                               options: UIViewAnimationOptionTransitionCrossDissolve
                            animations: ^(void)
             {
                 [listChapVCL.tableView reloadData];
                 [listChapVCL viewDidLoad];
             }
                            completion: nil];
        });
    });
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
