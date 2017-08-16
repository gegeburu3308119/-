//
//  ZCTabBarController.m
//  大葱内涵
//
//  Created by 张聪 on 16/4/28.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import "ZCTabBarController.h"
#import "ZCMeViewController.h"
#import "ZCNewViewController.h"
#import "ZCJingHuaViewController.h"
#import "ZCGuanZhuViewController.h"
#import "ZCTabBar.h"
#import "ZCNavigationController.h"
#import "ZCbackGroundView.h"
#import "ZCPublishViewController.h"
#import "ZCPostViewController.h"
@interface ZCTabBarController ()

@end

@implementation ZCTabBarController

+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    // 添加子控制器
    [self setupChildVc:[[ZCJingHuaViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setupChildVc:[[ZCNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setupChildVc:[[ZCGuanZhuViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupChildVc:[[ZCMeViewController alloc] initWithStyle:UITableViewStyleGrouped] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    ZCTabBar *tabar = [[ZCTabBar alloc] init];
    // 更换tabBar
    [self setValue:tabar forKeyPath:@"tabBar"];
    [tabar setButtonClick:^{
        ZCLog(@"ok");
//        ZCNavigationController *nav = [[ZCNavigationController alloc]initWithRootViewController:[[ZCPublishViewController alloc]init]];
        [self presentViewController:[[ZCPublishViewController alloc]init] animated:YES completion:nil];
    }];
    
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    ZCNavigationController *nav = [[ZCNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
   
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
