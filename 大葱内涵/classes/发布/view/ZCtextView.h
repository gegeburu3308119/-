//
//  ZCtextView.h
//  大葱内涵
//
//  Created by 张聪 on 16/5/10.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCtextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic,copy)void(^deletebackwordBlock)();
@end
