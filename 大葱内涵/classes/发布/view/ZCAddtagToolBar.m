//
//  ZCAddtagToolBar.m
//  大葱内涵
//
//  Created by 张聪 on 16/5/13.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import "ZCAddtagToolBar.h"
#import "ZcAddTagViewController.h"
@interface ZCAddtagToolBar ()
@property (weak, nonatomic) IBOutlet UIView *topview;
@property (weak, nonatomic) UIButton *addButton;
/** 存放所有的标签label */
@property (weak, nonatomic) IBOutlet UIView *bottomview;
@property (nonatomic, strong) NSMutableArray *tagLabels;
@end
@implementation ZCAddtagToolBar
- (NSMutableArray *)tagLabels
{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}
-(void)awakeFromNib{
    UIButton *addButton = [[UIButton alloc] init];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addButton.size = addButton.currentImage.size;
    addButton.x = 10;
    [self.topview addSubview:addButton];
    self.addButton = addButton;
    self.autoresizingMask =  UIViewAutoresizingNone;

}
+(instancetype)toolbar{

    return  [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];


}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    for (int i = 0; i<self.tagLabels.count; i++) {
        UILabel *tagLabel = self.tagLabels[i];
        
        // 设置位置
        if (i == 0) { // 最前面的标签
            tagLabel.x = 0;
            tagLabel.y = 0;
        } else { // 其他标签
            UILabel *lastTagLabel = self.tagLabels[i - 1];
            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + 7;
            // 计算当前行右边的宽度
            CGFloat rightWidth = self.topview.width - leftWidth;
            if (rightWidth >= tagLabel.width) { // 按钮显示在当前行
                tagLabel.y = lastTagLabel.y;
                tagLabel.x = leftWidth;
            } else { // 按钮显示在下一行
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastTagLabel.frame) + 7;
            }
        }
    }
    
    // 最后一个标签
    UILabel *lastTagLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + 7;
    
    // 更新textField的frame
    if (self.topview.width - leftWidth >= self.addButton.width) {
        self.addButton.y = lastTagLabel.y;
        self.addButton.x = leftWidth;
    } else {
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(lastTagLabel.frame) + 7;
    }
    CGFloat oldH  = self.height;
    self.height = CGRectGetMaxY(self.addButton.frame) + 45;
    //self.y -= self.height - oldH;


}
- (void)createTagLabels:(NSArray *)tags{

    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    for (int i = 0; i<tags.count; i++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        [self.tagLabels addObject:tagLabel];
        tagLabel.backgroundColor = ZCColor(74, 139, 209);
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.text = tags[i];
        tagLabel.font = [UIFont systemFontOfSize:14];
        // 应该要先设置文字和字体后，再进行计算
        [tagLabel sizeToFit];
        tagLabel.width += 2 * 7;
        tagLabel.height =25;
        tagLabel.textColor = [UIColor whiteColor];
        [self.topview addSubview:tagLabel];
    }
    [self setNeedsLayout];
    
}
- (void)addButtonClick
{
    ZcAddTagViewController *vc = [[ZcAddTagViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    [vc setTagBlock:^(NSArray *tags) {
        [weakSelf createTagLabels:tags];
    }];
    //vc.tags = [self.tagLabels valueForKeyPath:@"text"];
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)root.presentedViewController;
    [nav pushViewController:vc animated:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
