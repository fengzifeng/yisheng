//
//  RootViewController.m
//  MCFriends
//
//  Created by fengzifeng on 14-3-16.
//  Copyright (c) 2014年 fengzifeng. All rights reserved.
//

#import "MCHomeViewController.h"
#import "FFSeekViewController.h"
#import "MCHVButton.h"
#import "FFVideoViewController.h"
#import "FFMainViewController.h"

@interface MCHomeViewController ()
{
    NSArray *navArray;
}
@end

@implementation MCHomeViewController
@synthesize currentViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _selectedIndex = -1;
        navArray = @[[self viewControllerWithClass:[FFMainViewController class]],  //
                     [self viewControllerWithClass:[FFVideoViewController class]],    //
                     [self viewControllerWithClass:[FFSeekViewController class]], //
                     ];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    unreadPlate.layer.masksToBounds = YES;
    unreadPlate.layer.cornerRadius = 4;
    unreadActive.layer.masksToBounds = YES;
    unreadActive.layer.cornerRadius = 4;

    int i = 0;
    for (MCHVButton *item in _tabButtonCollection) {
        
        item.image_size = CGSizeMake(23, 22.5);

    }
    

    
    [_tabBarView setBlurColor:[UIColor whiteColor]];
    [_tabLineLabel autoSetDimension:ALDimensionHeight toSize:0.5];
    
    [self tabButtonAction:_tabButtonCollection[0]];
}


- (UIViewController *)viewControllerWithClass:(Class)class
{
    return [[class alloc] initWithNibName:NSStringFromClass(class) bundle:nil];
}

- (void)swithchTapIndex:(NSInteger)index
{
    if (_selectedIndex == index) {
        return;
    }
    
    for (UIButton *item in _tabButtonCollection) {
        item.selected = index==item.tag;
    }
    
    [currentViewController.view removeFromSuperview];
    [currentViewController removeFromParentViewController];
    
    _selectedIndex = index;
    
    currentViewController = [navArray objectAtIndex:index];
    [self addChildViewController:currentViewController];
    [self.view insertSubview:currentViewController.view belowSubview:_tabLineLabel];
    [currentViewController.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    [currentViewController initNavigationBar];

}

- (IBAction)tabButtonAction:(UIButton *)sender
{
    UIViewController *tmpVC = [navArray objectAtIndex:sender.tag];
    if ([currentViewController isEqual:tmpVC]) {
        [currentViewController updateDisplay];
        return;
    }
    
    [self swithchTapIndex:sender.tag];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
