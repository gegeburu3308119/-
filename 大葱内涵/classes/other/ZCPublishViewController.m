//
//  ZCPublishViewController.m
//  大葱内涵
//
//  Created by 张聪 on 16/5/6.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import "ZCPublishViewController.h"
#import "ZCPostViewController.h"
#import "ZCHelloViewController.h"
@interface ZCPublishViewController ()
@property (weak, nonatomic) IBOutlet UIButton *bacBtn;

@end
static CGFloat const ZCPUBLISHANIMATION_DELY    = 0.1;
static CGFloat const ZCSRINGFACTOR = 10;

@implementation ZCPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.alpha  =0.7;
//    self.view.userInteractionEnabled = NO;
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW+30;
    CGFloat buttonStartY = (ZCScreenH -2*buttonH)*0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (ZCScreenW - 2*buttonStartX -maxCols*buttonW)/(maxCols - 1);
    for (int i = 0; i<images.count; i++) {
        ZCButton *Btn= [ZCButton buttonWithType:UIButtonTypeCustom];
        Btn.tag  =i;
        [Btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside ];
        [self.view addSubview:Btn];
        [Btn setTitle:titles[i] forState:UIControlStateNormal];
        [Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [Btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        int row = i/maxCols;
        int col = i%maxCols;
        CGFloat buttonX = buttonStartX +col *(xMargin+buttonW);
        CGFloat buttonEndY = buttonStartY +(row*buttonH )+5;
        CGFloat buttonBeginY = buttonEndY - ZCScreenH;
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue  = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = 10;
        anim.springSpeed = 10;
        anim.beginTime = CACurrentMediaTime() + 0.1*i;
        [Btn pop_addAnimation:anim forKey:nil];
     
        
    }
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)buttonClick:(UIButton *)button{
//    ZCPostViewController *post = [[ZCPostViewController alloc]init];
//    ZCNavigationController *nav = [[ZCNavigationController alloc]initWithRootViewController:post];
//    [self presentViewController:nav animated:YES completion:nil];
    
    [self cancelWithCompletionBlock:^{
           // ZCPostViewController *post = [[ZCPostViewController alloc]init];
        ZCHelloViewController * post = [[ZCHelloViewController alloc]init];
        UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
            ZCNavigationController *nav = [[ZCNavigationController alloc]initWithRootViewController:post];
        [root presentViewController:nav animated:YES completion:nil];
       
        ZCLog(@"shit");
    }];
    

}
-(void)cancelWithCompletionBlock:(void(^)())completionBlock{
    self.view.userInteractionEnabled = NO;
    
    int beginIndex = 2;
    
    for (int i = beginIndex; i< self.view.subviews.count; i++) {
        UIView *subview = self.view.subviews[i];
        if ([subview isKindOfClass:[UIButton class]]) {
            POPBasicAnimation *anim = [POPBasicAnimation  animationWithPropertyNamed:kPOPViewCenter];
            anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, subview.centerY+ZCScreenH)];
            anim.beginTime = CACurrentMediaTime() +(i - beginIndex)*0.1;
            [subview pop_addAnimation:anim forKey:nil];
            //监听最后一个动画
            if (i == self.view.subviews.count-1) {
                [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                    [self dismissViewControllerAnimated:NO completion:nil];
                    !completionBlock ? :completionBlock();
                }];
            }
            
        }
    }

}
- (IBAction)back:(id)sender {
    [self cancelWithCompletionBlock:nil];
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
