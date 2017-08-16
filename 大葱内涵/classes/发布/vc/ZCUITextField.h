//
//  ZCUITextField.h
//  大葱内涵
//
//  Created by 张聪 on 16/5/16.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCUITextField : UITextField
@property (nonatomic,copy)void(^deleteBlock)();
@end
