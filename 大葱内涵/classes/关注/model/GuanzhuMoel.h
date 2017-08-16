//
//  GuanzhuMoel.h
//  大葱内涵
//
//  Created by 张聪 on 16/4/29.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import <Foundation/Foundation.h>
//"fans_count" = 68698;
//gender = 2;
//header = "http://wimg.spriteapp.cn/profile/large/2015/07/12/55a275d48591f_mini.jpg";
//introduction = "";
//"is_follow" = 0;
//"is_vip" = 0;
//"screen_name" = "Gif\U5c0f\U89c6\U9891\U5927\U53d4";
//"tiezi_count" = 634;
//uid = 437;

@interface GuanzhuMoel : NSObject
@property (nonatomic,strong)NSString*fans_count;
@property (nonatomic,strong)NSString*gender;
@property (nonatomic,strong)NSString*header;
@property (nonatomic,strong)NSString*introduction;
@property (nonatomic,strong)NSString*is_follow;
@property (nonatomic,strong)NSString*is_vip;
@property (nonatomic,strong)NSString*screen_name;
@property (nonatomic,strong)NSString*tiezi_count;
@property (nonatomic,strong)NSString*uid;
-(instancetype)initWithdic:(NSDictionary*)dic;
@end
