//
//  ZCMeBtnModel.h
//  大葱内涵
//
//  Created by 张聪 on 16/5/10.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCMeBtnModel : NSObject
/*            android = "";
 icon = "http://img.spriteapp.cn/ugc/2015/05/20/150532_5078.png";
 id = 28;
 ipad = "";
 iphone = "";
 market = "";
 name = "\U5ba1\U8d34";
 url = "mod://BDJ_To_Check";
 */
@property (nonatomic,strong)NSString*ID;
@property (nonatomic,strong)NSString*name;
@property (nonatomic,strong)NSString*icon;
@property (nonatomic,strong)NSString*market;
-(instancetype)initWithDic:(NSDictionary*)dic;
@end
