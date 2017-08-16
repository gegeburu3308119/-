//
//  ZCmeCell.m
//  大葱内涵
//
//  Created by 张聪 on 16/5/10.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import "ZCmeCell.h"

@implementation ZCmeCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIImageView *bgView = [[UIImageView alloc]init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView=bgView;
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    return self;

}
-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.imageView.image==nil) {
        return;
    }
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.contentView.height*0.5;
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) +10;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
