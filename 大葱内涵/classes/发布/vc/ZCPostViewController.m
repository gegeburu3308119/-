//
//  ZCPostViewController.m
//  大葱内涵
//
//  Created by 张聪 on 16/5/11.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import "ZCPostViewController.h"
#include "ZCtextView.h"
#import "ZcAddTagViewController.h"
#import "ZCAddtagToolBar.h"
#import "ZcAddTagViewController.h"
@interface ZCPostViewController ()<UITextViewDelegate>
@property (nonatomic,weak)ZCtextView *textView;
@property (nonatomic,weak)UIView*toolbar;
@end

@implementation ZCPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
     [self setupTextView];
    [self setupToolbar];
    [self.textView becomeFirstResponder];
    // Do any additional setup after loading the view from its nib.
}
- (void)setupToolbar
{
    ZCAddtagToolBar *toolbar = [ZCAddtagToolBar toolbar];
    toolbar.width = self.view.width;
    toolbar.y = ZCScreenH - toolbar.height;
    toolbar.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:toolbar];
//    [toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).with.offset(0);
//        make.right.equalTo(self.view).with.offset(0);
//        make.height.mas_equalTo(50);
//        make.bottom.equalTo(self.view);
//    }];
    self.toolbar = toolbar;


    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
   
    // Dispose of any resources that can be recreated.
}
- (void)setupNav
{
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO; // 默认不能点击
    // 强制刷新
    [self.navigationController.navigationBar layoutIfNeeded];
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
//    // 键盘最终的frame
//    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    
//    // 动画时间
//    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    
//    [UIView animateWithDuration:duration animations:^{
//        self.toolbar.transform = CGAffineTransformMakeTranslation(0,  keyboardF.origin.y - ZCScreenH);
//        
//    }];
    CGRect keyF = [note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, keyF.origin.y - ZCScreenH);
//        [self.toolbar mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(keyF.size.height);
//        }];
    }];
}
- (void)cancel
{    [self.textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post
{
   
}
- (void)setupTextView
{
    ZCtextView *textView = [[ZCtextView alloc] init];
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理查你水表的。";
    textView.frame = self.view.bounds;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
   
}
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
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
