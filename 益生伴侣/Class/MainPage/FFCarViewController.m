//
//  FFCarViewController.m
//  益生伴侣
//
//  Created by fengzifeng on 2017/11/24.
//  Copyright © 2017年 fengzifeng. All rights reserved.
//

#import "FFCarViewController.h"

@interface FFCarViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_indexTitleArray;
    NSMutableArray *_dataSourceArray;
    
    NSMutableDictionary *_favUserDic;
    UIButton *_rightNavButton;
    
    UILabel *_friendsNumLabel;
    UITableView *_tableView;

}
@end

@implementation FFCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择品牌";
    [self setNavigationBackButtonDefault];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _topInset, SCREEN_WIDTH, SCREEN_HEIGHT - _topInset) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _dataSourceArray = [@[@[@"奥迪",@"奥迪",@"奥迪",@"奥迪",@"奥迪"],@[@"奔驰",@"奔驰",@"奔驰",@"奔驰",@"奔驰",@"奔驰",@"奔驰",@"奔驰",@"奔驰"],@[@"吃了",@"吃了",@"吃了",@"吃了",@"吃了",@"吃了",@"吃了",@"吃了",@"吃了",@"吃了"]] mutableCopy];
    
    _indexTitleArray = [@[@"a",@"b",@"c"] mutableCopy];
    self.view.backgroundColor = [UIColor whiteColor];
    [_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [_dataSourceArray[section] count];
    return count;
}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    return _indexTitleArray;
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return _indexTitleArray[section];
//}
//
//-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString*)title atIndex:(NSInteger)index
//{
//    return index;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 22)];
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 22)];
    textLabel.font = [UIFont boldSystemFontOfSize:13];
    textLabel.text = _indexTitleArray[section];
    
    textLabel.textColor = [UIColor grayColor];
    textLabel.backgroundColor = [UIColor clearColor];
    headerView.backgroundColor = RGBCOLOR(241, 241, 241);;
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 21.5, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = HexColor(0xCCCCCC);
    [headerView addSubview:line];
    [headerView addSubview:textLabel];
    
    return headerView;
}

- (void)requestData
{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = _dataSourceArray[indexPath.section][indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

//        cell = [[[NSBundle mainBundle] loadNibNamed:@"cell" owner:self options:nil] firstObject];
    }
    cell.textLabel.text = str;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    NSDictionary *cellInfo = _dataSourceArray[indexPath.section][indexPath.row];
    if ([self.delegate respondsToSelector:@selector(showUpdateAnimation)]) {
        [self.delegate showUpdateAnimation];
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:true];

    
}

@end
