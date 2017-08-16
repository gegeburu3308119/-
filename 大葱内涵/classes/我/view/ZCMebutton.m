//
//  ZCMebutton.m
//  大葱内涵
//
//  Created by 张聪 on 16/5/10.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import "ZCMebutton.h"
#import "ZCMeBtnModel.h"
#import "UIButton+WebCache.h"
@implementation ZCMebutton
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
-(void)awakeFromNib{
    [self setup];

}
- (void)setup{

        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];

}
-(void)layoutSubviews{
   [super layoutSubviews];
    // 调整图片
    self.imageView.y = self.height * 0.15;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    


}
- (void)setModel:(ZCMeBtnModel *)model{

    _model = model;
    [self setTitle:model.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:model.icon] forState:UIControlStateNormal];


}
//- (void)setFrame:(CGRect)frame
//{
//    //    XMGLog(@"%@", NSStringFromCGRect(frame));
//    frame.origin.y -= (35 - 10);
//    [super setFrame:frame];
//}
@end
