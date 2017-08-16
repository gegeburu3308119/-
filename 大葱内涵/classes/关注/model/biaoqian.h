//
//  biaoqian.h
//  大葱内涵
//
//  Created by 张聪 on 16/4/29.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Biaoqian : NSObject
@property (nonatomic,assign)NSInteger ID;
@property (nonatomic,strong)NSString* name;
@property (nonatomic,assign)NSInteger count;

@property (nonatomic,strong)NSMutableArray* users;//右边数据
@end
