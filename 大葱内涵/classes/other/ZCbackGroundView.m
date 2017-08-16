//
//  ZCbackGroundView.m
//  大葱内涵
//
//  Created by 张聪 on 16/5/3.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import "ZCbackGroundView.h"

@implementation ZCbackGroundView
+(instancetype)backView{
   
    return [[[NSBundle mainBundle]loadNibNamed:@"ZCbackGroundView" owner:nil options:nil]lastObject];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self removeFromSuperview];

}

@end
