//
//  ZCJingHuaViewController.m
//  大葱内涵
//
//  Created by 张聪 on 16/4/28.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import "ZCJingHuaViewController.h"

#import "ZCDuanZiTableViewController.h"

#import "ZCbackGroundView.h"
@interface ZCJingHuaViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIView* indicatorview;
@property (nonatomic,strong)UIButton* selectedBtn;
@property (nonatomic,weak)UIScrollView* contentView;
@property (nonatomic,weak)UIView *titlesView;
@end

@implementation ZCJingHuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    self.view.backgroundColor = ZCGLObalColor;
    self.navigationItem.titleView  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
     [self setupTitlesView];
    [self setupChildVC];
    [self setupConntentView];
   
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    ZCbackGroundView *backv = [ZCbackGroundView backView];
    backv.frame = self.view.bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:backv];
    // Do any additional setup after loading the view.
}
- (void)setupConntentView{//滚动视图
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contview = [[UIScrollView alloc]init];
    contview.frame = self.view.frame;
    contview.width = self.view.width;
    contview.backgroundColor = [UIColor clearColor];
    contview.delegate = self;
    contview.pagingEnabled = YES;
    contview.contentSize = CGSizeMake(contview.width*self.childViewControllers.count, 0);
    self.contentView = contview;
     [self.view insertSubview:_contentView atIndex:0];
    [self scrollViewDidEndScrollingAnimation:contview];

}
-(void)setupChildVC{
    
//    typedef enum {
//        XMGTopicTypeAll = 1,
//        XMGTopicTypePicture = 10,
//        XMGTopicTypeWord = 29,
//        XMGTopicTypeVoice = 31,
//        XMGTopicTypeVideo = 41
//    } XMGTopicType;
    
    ZCDuanZiTableViewController *all = [[ZCDuanZiTableViewController alloc]init];
    all.type = XMGTopicTypeAll;
    [self addChildViewController:all];
    ZCDuanZiTableViewController *video = [[ZCDuanZiTableViewController alloc]init];
    video.type = XMGTopicTypeVideo;
    [self addChildViewController:video];
    ZCDuanZiTableViewController *audio = [[ZCDuanZiTableViewController alloc]init];
    audio.type = XMGTopicTypeVoice;
    [self addChildViewController:audio];
    ZCDuanZiTableViewController *pic = [[ZCDuanZiTableViewController alloc]init];
    pic.type = XMGTopicTypePicture;
    [self addChildViewController:pic];
    ZCDuanZiTableViewController *duanzi = [[ZCDuanZiTableViewController alloc]init];
    duanzi.type = XMGTopicTypeWord;
    [self addChildViewController:duanzi];


}
-(void)setupTitlesView{
    UIView *v = [[UIView alloc]init];
    v.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    v.width = self.view.width;
    v.height = 35;
    v.y = 64;
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    [self.view addSubview:v];
    UIView *indicatorView = [[UIView alloc]init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = v.height - 2;
    indicatorView.tag = -1;
    _indicatorview.width = _selectedBtn.width;
    _indicatorview =indicatorView;
    [v addSubview:indicatorView];
    for (int i = 0; i<5; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.height = v.height;
        btn.width = v.width/5;
        btn.tag = i+1;
        btn.x = i*btn.width;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn layoutIfNeeded];
        [btn  setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn  setTitleColor:[UIColor redColor] forState:UIControlStateDisabled ];
        [btn layoutIfNeeded];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [v addSubview:btn];
        if (i == 0) {
            btn.enabled = YES;
            self.selectedBtn = btn;
            [btn.titleLabel sizeToFit];
            self.indicatorview.centerX = btn.centerX;
            [self titleClick:btn];
        }
    }
    
 
    self.titlesView = v;

}
-(void)titleClick:(UIButton*)sender{
    // 修改按钮状态
    self.selectedBtn.enabled = YES;
    sender.enabled = NO;
    self.selectedBtn =sender;
    NSInteger a = 20;
    if ([sender isKindOfClass:[UIButton class]]) {
      a =  sender.titleLabel.width;
    }
   

   [UIView animateWithDuration:0.25 animations:^{
      
       self.indicatorview.width = a;
       self.indicatorview.centerX = sender.centerX;
   
   }];
   
    CGPoint offset = self.contentView.contentOffset;
    offset.x = self.contentView.width*(sender.tag -1);
    [self.contentView setContentOffset:offset animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tagClick{



}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
  

    NSInteger index  = scrollView.contentOffset.x/scrollView.width;
 
    UITableViewController *vc = self.childViewControllers[index];
     vc.view.x =   scrollView.contentOffset.x;
    vc.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top  = CGRectGetMaxY(self.titlesView.frame);
    vc.tableView.contentInset = UIEdgeInsetsMake(top-20, 0, bottom, 0);

    [scrollView addSubview:vc.view];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    [self scrollViewDidEndScrollingAnimation:scrollView];
 
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick: [self.titlesView viewWithTag:(index+1)]];

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
