//
//  FFReceivieOrderViewController.m
//  3D社群
//
//  Created by fengzifeng on 2017/11/22.
//  Copyright © 2017年 fengzifeng. All rights reserved.
//

#import "FFReceivieOrderViewController.h"
#import "FFSliderViewController.h"
#import "FFCarViewController.h"
#import "FFTurnOrderViewController.h"
#import "FFViewController.h"

@interface FFReceivieOrderViewController ()

@end

@implementation FFReceivieOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.parentViewController setNavigationTitleView:nil];
    self.parentViewController.title = @"接单";
}

- (IBAction)click:(id)sender
{
//    FFSliderViewController *vc = [[FFSliderViewController alloc] init];
    
    FFSliderViewController *vc = [[FFSliderViewController alloc] initWithRootViewController:[[FFCarViewController alloc] init] contentViewController:[[FFViewController alloc] init]];

//    vc.LeftVC = [[FFViewController alloc] init];
//    vc.LeftVC.view.frame = CGRectMake(0, 70, SCREEN_WIDTH - 10, 560);
//    [vc setLeftShow:^{
//
//    }];
//
//    vc.MainVC = [FFCarViewController viewController];
//    FFCarViewController *vc = [[FFCarViewController alloc] init];

    [self.navigationController pushViewController:vc animated:YES];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [vc showLeftViewController];
//
//    });

    
}
@end
