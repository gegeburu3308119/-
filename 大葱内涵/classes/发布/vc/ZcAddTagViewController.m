//
//  ZcAddTagViewController.m
//  大葱内涵
//
//  Created by 张聪 on 16/5/13.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import "ZcAddTagViewController.h"
#import "ZCUITextField.h"
@interface ZcAddTagViewController ()<UITextFieldDelegate>
/** 内容 */
@property (nonatomic, weak) UIView *contentView;
/** 文本输入框 */
@property (nonatomic, weak) ZCUITextField *textField;
/** 添加按钮 */
@property (nonatomic, weak) UIButton *addButton;
/** 所有的标签按钮 */
@property (nonatomic, strong) NSMutableArray *tagButtons;
@end

@implementation ZcAddTagViewController
- (NSMutableArray *)tagButtons
{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}

- (UIView *)contentView
{
    if (!_contentView) {
        UIView *contentView = [[UIView alloc] init];
        [self.view addSubview:contentView];
        self.contentView = contentView;
    }
    return _contentView;
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.contentView.x =  5;
    self.contentView.width = self.view.width - 2 *self.contentView.x;
    self.contentView.y = 64 + 5;
    self.contentView.height = ZCScreenH;
    self.textField.width = self.contentView.width;
    self.textField.height = 25;
    self.addButton.y = CGRectGetMaxY(_textField.frame);
    self.addButton.width = self.contentView.width;
    
}
-(UIButton *)addButton{
    if (!_addButton) {
        UIButton * addbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        addbutton.height = 35;
        [addbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addbutton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        addbutton.titleLabel.font = [UIFont systemFontOfSize:15];
        addbutton.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
        addbutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        addbutton.backgroundColor =  ZCColor(74, 139, 209);
        [self.contentView addSubview:addbutton];
        _addButton = addbutton;
        
    }
    return _addButton;

}
- (void)setupTags
{
    if (self.tags.count) {
        for (NSString *tag in self.tags) {
            self.textField.text = tag;
            [self addButtonClick];
        }
        
        self.tags = nil;
    }
}

- (void)addButtonClick
{
    if (self.tagButtons.count == 5) {
        [SVProgressHUD showErrorWithStatus:@"最多添加5个标签" maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    UIButton *tagbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagbutton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
     [tagbutton setTitle:self.textField.text forState:UIControlStateNormal];
    [tagbutton sizeToFit];
    tagbutton.width += 3*5;
    tagbutton.height = 25;
   
    [tagbutton setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
    tagbutton.contentEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 2);
    
    tagbutton.backgroundColor = ZCColor(74, 139, 209);
    tagbutton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:tagbutton];
    [self.tagButtons addObject:tagbutton];
    self.textField.text  = nil;
    self.addButton.hidden = YES;
    
    [self updateTagButtonFrame];
    [self updateTextFieldFrame];
    
    
}

- (void)tagButtonClick:(UIButton *)tagButton
{
   [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    
    // 重新更新所有标签按钮的frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
        [self updateTextFieldFrame];
    }];
}
- (void)updateTagButtonFrame
{
    for (int i = 0; i< self.tagButtons.count; i++) {
        UIButton *tagbtn = self.tagButtons[i];
        if (i == 0) {
            tagbtn.x = 0;
            tagbtn.y = 0;
        }else{
        
        UIButton *lastbtn = self.tagButtons[i-1];
        CGFloat leftWidth = CGRectGetMaxX(lastbtn.frame)+7;
        CGFloat rightWidth = self.contentView.width - leftWidth;
        if (rightWidth >= tagbtn.width) {
                tagbtn.y  = lastbtn.y;
                tagbtn.x = leftWidth;
                
            }else{
                tagbtn.x = 0;
                tagbtn.y  = CGRectGetMaxY(lastbtn.frame) +7;
            
            }
        
        }
        
    }


}
-(void)updateTextFieldFrame{
    UIButton *lastbtn = [self.tagButtons lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastbtn.frame) +7;
    
    if (self.contentView.width - leftWidth >= [self textFieldTextWidth]) {
        self.textField.y  = lastbtn.y;
        self.textField.x = leftWidth;
    }else{
        self.textField.x  = 0;
        self.textField.y = CGRectGetMaxY(self.textField.frame) +7;
    
    }
 
}
- (CGFloat)textFieldTextWidth {
    CGFloat  textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName:self.textField.font}].width;
    return  MAX(100, textW);


}
-(ZCUITextField*)textField{
    if (!_textField) {
        ZCUITextField * textFiled = [[ZCUITextField alloc]init];
        textFiled.delegate = self;
        [textFiled addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:textFiled];
        [textFiled setDeleteBlock:^{
            if (self.tagButtons.count>0&&!self.textField.hasText) {
                UIButton * tag =   [self.tagButtons lastObject];
                [tag removeFromSuperview];
                [self.tagButtons removeLastObject];
                [self updateTagButtonFrame];
                [self updateTextFieldFrame];
            }
        }];
        _textField = textFiled;
    }
    return _textField;

}
- (void)textDidChange{
    
//    [self updateTextFieldFrame];
    if (self.textField.hasText) {
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame)+5;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签: %@",self.textField.text] forState:UIControlStateNormal];
    }else{
        self.addButton.hidden = YES;
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView.x =  5;
    self.contentView.width = self.view.width - 2 *self.contentView.x;
    self.contentView.y = 64 + 5;
    self.contentView.height = ZCScreenH;
    self.textField.width = self.contentView.width;
    self.textField.x = 5;
    self.textField.y = 5;
    self.textField.placeholder = @"输入标签";
    self.textField.height = 25;
     [self setupNav];
    // Do any additional setup after loading the view.
}
- (void)setupNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)done
{
    // 传递数据给上一个控制器
    //    NSMutableArray *tags = [NSMutableArray array];
    //    for (XMGTagButton *tagButton in self.tagButtons) {
    //        [tags addObject:tagButton.currentTitle];
    //    }
    // 传递tags给这个block
//    NSArray *tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
//    !self.tagsBlock ? : self.tagsBlock(tags);
    NSMutableArray *tags = [NSMutableArray array];
    for (UIButton * tagbutn in self.tagButtons) {
        [tags addObject:tagbutn.currentTitle];
    }
    !self.tagBlock?:self.tagBlock(tags);
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.hasText) {
        [self addButtonClick];
    }
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
