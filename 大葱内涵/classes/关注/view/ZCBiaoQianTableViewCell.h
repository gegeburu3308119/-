//
//  ZCBiaoQianTableViewCell.h
//  大葱内涵
//
//  Created by 张聪 on 16/4/29.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Biaoqian.h"
@interface ZCBiaoQianTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIView *leftV;
@property (nonatomic,strong)Biaoqian* biaoqian;
@end
