//
//  XMGTopicCell.h
//  01-百思不得姐
//
//  Created by xiaomage on 15/7/27.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCword.h"
#import "ZCPictureView.h"
@interface XMGTopicCell : UITableViewCell
/** 帖子数据 */
@property (nonatomic, strong) ZCword *topic;
@end
