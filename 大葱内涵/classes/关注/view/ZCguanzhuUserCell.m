//
//  ZCguanzhuUserCell.m
//  大葱内涵
//
//  Created by 张聪 on 16/4/29.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import "ZCguanzhuUserCell.h"

@implementation ZCguanzhuUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(GuanzhuMoel *)model{
    _model = model;
    self.namelabel.text = model.screen_name;
    self.countlabel.text = [NSString stringWithFormat:@"%@人关注",model.fans_count];
    [self.headerimgv sd_setImageWithURL:[NSURL URLWithString:model.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}
@end
