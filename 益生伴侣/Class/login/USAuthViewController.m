//
//  USAuthViewController.m
//  USEvent
//
//  Created by fengzifeng on 15/9/15.
//  Copyright (c) 2015年 fengzifeng. All rights reserved.
//

#import "USAuthViewController.h"
#import "FFLoginCell.h"
#import "DrBaseWebViewController.h"

@interface USAuthViewController ()

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) FFLoginUser *loginObj;


@end

@implementation USAuthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    self.navigationBar.hidden = YES;
    
    if (_type == loginType) {
        _titleArray = @[@"手机",@"密码"];
    } else if (_type == reginType){
        _titleArray = @[@"手机",@"密码",@"重复密码"];
    }
    
    _tableView.tableHeaderView = [self getHeadView];
    _tableView.tableFooterView = [self getFootView];
    _loginObj = [[FFLoginUser alloc] init];
    __weak typeof(self) weakSelf = self;
    [self.view setTapActionWithBlock:^{
        [weakSelf.view endEditing:YES];
    }];
}

- (UIView *)getHeadView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"注册" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(100, 20, 100, 40);
    [headView addSubview:leftButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"登录" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(240, 20, 100, 40);
    [headView addSubview:rightButton];
    
    return headView;
}

- (UIView *)getFootView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 102)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithColor:HexColor(0xaa2d1b)] forState:UIControlStateNormal];
    button.frame = CGRectMake(19, 22, SCREEN_WIDTH - 19*2, 42);
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    [button addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    if (_type == loginType) {
        [button setTitle:@"确定" forState:UIControlStateNormal];
    } else if (_type == reginType) {
        [button setTitle:@"注册" forState:UIControlStateNormal];
    }

    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"FFLoginCell";
    FFLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] firstObject];
        cell.loginObj = _loginObj;
        cell.type = _type;
    }
    
    [cell updateCell:_titleArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.f;
}

- (void)login
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@/%@/%@",url_register,_loginObj.username,_loginObj.password,_loginObj.email];
    if (_type == loginType) {
        requestUrl = [NSString stringWithFormat:@"%@%@/%@",url_login,_loginObj.username,_loginObj.password];
    }
//    [USSuspensionView showWithMessage:@"发送成功"];

    [[DrHttpManager defaultManager] getRequestToUrl:requestUrl params:nil complete:^(BOOL successed, HttpResponse *response) {
        if (successed) {
            if (_type == loginType) {
                [USSuspensionView showWithMessage:@"登录成功"];
            } else if (_type == reginType) {
                [USSuspensionView showWithMessage:@"注册成功"];
                FFLoginUser *user = [FFLoginUser objectWithKeyValues:response.payload[@"data"]];
            }
        } else {
            
        }
    }];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
