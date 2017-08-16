//
//  ZcAddTagViewController.h
//  大葱内涵
//
//  Created by 张聪 on 16/5/13.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZcAddTagViewController : UIViewController
/** 所有的标签 */
@property (nonatomic,copy)void(^tagBlock)(NSArray*tags);
@property (nonatomic, strong) NSArray *tags;
@end
