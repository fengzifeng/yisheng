//
//  FFTurnOrderViewController.m
//  3D社群
//
//  Created by fengzifeng on 2017/11/22.
//  Copyright © 2017年 fengzifeng. All rights reserved.
//

#import "FFTurnOrderViewController.h"

@interface FFTurnOrderViewController ()

@end

@implementation FFTurnOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.parentViewController setNavigationTitleView:nil];
    self.parentViewController.title = @"转单";
}


@end
