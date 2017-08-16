//
//  ZCBiaoQianTableViewCell.m
//  大葱内涵
//
//  Created by 张聪 on 16/4/29.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import "ZCBiaoQianTableViewCell.h"

@implementation ZCBiaoQianTableViewCell

- (void)awakeFromNib {
//    self.textLabel.highlightedTextColor = [UIColor redColor];
    self.backgroundColor = ZCColor(244,244 , 244);
    self.line.hidden = YES;

    // Initialization code
}
-(void)setBiaoqian:(Biaoqian *)biaoqian{
    _biaoqian = biaoqian;
  
    self.textLabel.text = biaoqian.name;

}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.textLabel.height = self.textLabel.height-2;

}
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated] ;
    self.leftV.hidden = !selected;
   
    self.textLabel.textColor = selected?ZCColor(219, 21, 26):ZCColor(78, 78, 78);

}
@end

