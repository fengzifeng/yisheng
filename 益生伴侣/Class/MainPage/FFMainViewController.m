//
//  FFReceivieOrderViewController.m
//  益生伴侣
//
//  Created by fengzifeng on 2017/11/22.
//  Copyright © 2017年 fengzifeng. All rights reserved.
//

#import "FFMainViewController.h"

@interface FFMainViewController ()

@end

@implementation FFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.parentViewController setNavigationTitleView:nil];
    self.parentViewController.title = @"益生伴侣";
}

- (IBAction)click:(id)sender
{


    
}
@end
