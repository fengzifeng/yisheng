//
//  FFCarViewController.h
//  3D社群
//
//  Created by fengzifeng on 2017/11/24.
//  Copyright © 2017年 fengzifeng. All rights reserved.
//

#import "MCViewController.h"

@protocol FFCarViewControllerDelegate <NSObject>

-(void)showUpdateAnimation;

@end

@interface FFCarViewController : MCViewController

@property (weak, nonatomic) id <FFCarViewControllerDelegate> delegate;

@end
