//
//  ZCtextView.m
//  大葱内涵
//
//  Created by 张聪 on 16/5/10.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import "ZCtextView.h"
@interface ZCtextView()

@property (nonatomic,weak) UILabel *placeholderLabel;

@end
@implementation ZCtextView
-(UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        UILabel *placeholderLabel = [[UILabel alloc]init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.x = 4;
        placeholderLabel.y = 7;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    return _placeholderLabel;


}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.alwaysBounceHorizontal = NO;
        self.alwaysBounceVertical = YES;
        self.font = [UIFont systemFontOfSize:15];
        self.placeholderColor = [UIColor grayColor];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)textDidChange{

    self.placeholderLabel.hidden = self.hasText;

}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    
//    CGSize size = [self.placeholder boundingRectWithSize:CGSizeMake(ZCScreenW - 20, 10000) options:0 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
//    self.placeholderLabel.frame = CGRectMake(4,7 , size.width, size.height);
    [self.placeholderLabel sizeToFit];
    self.placeholderLabel.width = ZCScreenW-14;

}
-(void)setPlaceholderColor:(UIColor *)placeholderColor{

    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;

}
-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
    [self setNeedsLayout];
}
-(void)setText:(NSString *)text{
    [super setText:text];
    [self textDidChange];
    
}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    [self setNeedsLayout];
}
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}
-(void)deleteBackward{
    [super deleteBackward];
  
}
@end
