//
//  ZCHelloViewController.m
//  大葱内涵
//
//  Created by 张葱 on 17/3/7.
//  Copyright © 2017年 张聪. All rights reserved.
//

#import "ZCHelloViewController.h"

@interface ZCHelloViewController ()
@property (nonatomic,weak)UIView * tool;
@end

@implementation ZCHelloViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    UIView * v = [[UIView alloc]initWithFrame:self.view.bounds];
    v.backgroundColor = [UIColor redColor];
    [self.view addSubview:v];
    
    UIView * tool = [[UIView alloc]init];
    [self.view addSubview:tool];
    _tool = tool;
    tool.backgroundColor = [UIColor lightGrayColor];
    [tool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        //make.right.equalTo(self.view);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.view);
    }];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

   [_tool mas_updateConstraints:^(MASConstraintMaker *make) {
      
      make.bottom.equalTo(self.view).with.offset(-100);
      
   }];


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
