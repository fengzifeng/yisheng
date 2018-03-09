//
//  FFTurnOrderViewController.m
//  益生伴侣
//
//  Created by fengzifeng on 2017/11/22.
//  Copyright © 2017年 fengzifeng. All rights reserved.
//

#import "FFVideoViewController.h"

@interface FFVideoViewController ()

@end

@implementation FFVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.parentViewController setNavigationTitleView:nil];
    self.parentViewController.title = @"益生伴侣";
}


@end
