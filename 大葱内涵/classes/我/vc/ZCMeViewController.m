//
//  ZCMeViewController.m
//  大葱内涵
//
//  Created by 张聪 on 16/4/28.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import "ZCMeViewController.h"
#import "ZCmeCell.h"
#import "ZCMeFootView.h"
@interface ZCMeViewController ()

@end

@implementation ZCMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refresh ) name:@"refreshTable"object:nil];
    // 设置导航栏标题
    self.navigationItem.title = @"我的";
    
    // 设置导航栏右边的按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
    [self setupTableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)refresh{

   

}
- (void)settingClick{


}
- (void)setupTableView{

    self.tableView.backgroundColor  = ZCGlobalBg;
    [self.tableView registerClass:[ZCmeCell class] forCellReuseIdentifier:@"me"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset   =  UIEdgeInsetsMake(-20, 0, 0, 0);
    ZCMeFootView* v =    [[ZCMeFootView alloc]init];
    __weak ZCMeFootView * weakFootView = v;
    [v setCompelte:^{
         self.tableView.tableFooterView = weakFootView;
    }];
    
    
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCmeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"me"];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登录/注册";
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}
-(void)moonClick{
    
    
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
