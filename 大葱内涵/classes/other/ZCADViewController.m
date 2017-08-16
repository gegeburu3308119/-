//
//  ZCADViewController.m
//  大葱内涵
//
//  Created by 张聪 on 16/5/5.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import "ZCADViewController.h"
#import "ZCTabBarController.h"
@interface ZCADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *jumpad;
@property (strong,nonatomic)NSTimer* timer;
@property (nonatomic,assign)NSInteger total;
@end

@implementation ZCADViewController
-(void)dealloc{
    self.timer =nil;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    _total = 7;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://img0.pcgames.com.cn/pcgames/1508/10/5425340_b15_thumb.jpg"] placeholderImage:nil];
    
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
    _timer  =timer;
    NSRunLoop *runloop=[NSRunLoop currentRunLoop];
    [runloop addTimer:_timer forMode:NSDefaultRunLoopMode];
    [_timer fire];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)jump:(id)sender {
    [self.timer invalidate];
    self.timer  = nil;
    self.view.window.rootViewController = [[ZCTabBarController alloc]init];
    
}
- (void)changeTime{
    _total--;
   
    [self.jumpad setTitle:[NSString stringWithFormat:@"跳过广告%ld",(long)_total] forState:0];
    if (_total == 0) {
        [self.timer invalidate];
        self.timer  = nil;
        self.view.window.rootViewController = [[ZCTabBarController alloc]init];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
