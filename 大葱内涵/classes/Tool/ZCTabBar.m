//
//  ZCTabBar.m
//  大葱内涵
//
//  Created by 张聪 on 16/4/28.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import "ZCTabBar.h"
@interface ZCTabBar()
@property (nonatomic,strong)UIButton*publishBtn;
@end

@implementation ZCTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        UIButton * publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside ];
        [self addSubview:publishBtn];
        self.publishBtn = publishBtn;
    
    }
    return self;
    
}
-(void)layoutSubviews{
    
   [super layoutSubviews];
    // 标记按钮是否已经添加过监听器
    static BOOL added = NO;
    
   
//
    _publishBtn.bounds = CGRectMake(0, 0, _publishBtn.currentBackgroundImage.size.width,_publishBtn.currentBackgroundImage.size.height);
//    // 设置发布按钮的frame
    self.publishBtn.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
       // 设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width/ 5;
    CGFloat buttonH = self.frame.size.height;
    NSInteger index = 0;
    for (UIControl *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")] || button == self.publishBtn) continue;
        
        // 计算按钮的x值
        CGFloat buttonX = buttonW * index;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 增加索引
        if (index == 1) {
            index++;
        }
        index++;
        
       


    }
    
    added = YES;


}
- (void)btnClick
{
  self.buttonClick();
    
}
@end
