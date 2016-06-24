//
//  ViewController.m
//  Final Project
//
//  Created by Hung Ga 123 on 6/14/16.
//  Copyright © 2016 HungVu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController != nil)
    {
        [self.barBtnItem setTarget: self.revealViewController];
        [self.barBtnItem setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    revealViewController.rearViewRevealWidth = 320;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
