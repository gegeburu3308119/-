//
//  ZCguanzhuUserCell.h
//  大葱内涵
//
//  Created by 张聪 on 16/4/29.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuanzhuMoel.h"
@interface ZCguanzhuUserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerimgv;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *countlabel;
@property (nonatomic,strong)GuanzhuMoel* model;
@end
