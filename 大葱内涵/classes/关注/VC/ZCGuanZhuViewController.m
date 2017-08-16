//
//  ZCGuanZhuViewController.m
//  大葱内涵
//
//  Created by 张聪 on 16/4/29.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import "ZCGuanZhuViewController.h"
#import "ZCTuiJianViewController.h"
#import "ZCLoginViewController.h"
@interface ZCGuanZhuViewController ()
@property (weak, nonatomic) IBOutlet UILabel *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *deslabel;

@end

@implementation ZCGuanZhuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    self.view.backgroundColor =ZCGLObalColor;
    self.deslabel.text = @"快快登录吧 款注更多牛人\n发动态过把瘾";
    // Do any additional setup after loading the view.
}
- (IBAction)login:(id)sender {
    ZCLoginViewController *loginv = [[ZCLoginViewController alloc]init];
    [self presentViewController:loginv animated:YES completion:nil];
                            
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)friendsClick{
    ZCTuiJianViewController *tuiVc = [[ZCTuiJianViewController alloc]initWithNibName:@"ZCTuiJianViewController" bundle:nil];
    [self.navigationController pushViewController:tuiVc animated:YES];

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
