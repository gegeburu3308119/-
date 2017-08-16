//
//  ZCButton.m
//  大葱内涵
//
//  Created by 张聪 on 16/5/6.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import "ZCButton.h"

@implementation ZCButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)awakeFromNib{
    [self setup];

}

-(void)setup{

    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    

}
-(void)layoutSubviews{
    [super layoutSubviews];
    //调整图片
    
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height -self.imageView.height;
    
    


}
@end
