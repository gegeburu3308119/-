//
//  ZCVidioView.h
//  大葱内涵
//
//  Created by 张聪 on 16/5/6.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCword.h"
@interface ZCVidioView : UIView
@property (nonatomic,strong)ZCword*topic;
+(instancetype)videoView;
@end
