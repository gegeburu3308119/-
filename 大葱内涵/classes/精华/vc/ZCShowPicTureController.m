
//
//  ZCShowPicTureController.m
//  大葱内涵
//
//  Created by 张聪 on 16/5/5.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import "ZCShowPicTureController.h"

@interface ZCShowPicTureController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet DACircularProgressView *zcprogress;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) UIImageView *imgview;
@end

@implementation ZCShowPicTureController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imgv = [[UIImageView alloc]init];
    imgv.userInteractionEnabled  =YES;
    [imgv addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)]];
    [self.scrollview addSubview:imgv];
    _scrollview.maximumZoomScale=2.0;
    _scrollview.minimumZoomScale=0.5;
    _scrollview.delegate = self;
    self.imgview = imgv;
    self.centerLabel.textColor =[UIColor whiteColor];
    CGFloat pictureW = ZCScreenW;
    CGFloat pictureH = pictureW *self.topic.height /self.topic.width;
    if (pictureH>ZCScreenH) {
        imgv.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollview.contentSize = CGSizeMake(pictureW, pictureH);
    }else{
        imgv.size = CGSizeMake(pictureW, pictureH);
        imgv.centerY = ZCScreenH*0.5;
    }
    [self.zcprogress setProgress:self.topic.pictureProgress animated:NO];
    
    [self.imgview sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [self.zcprogress setProgress:1.0*receivedSize/expectedSize animated:NO];
        self.centerLabel.text = [NSString stringWithFormat:@"%ld%%",100*receivedSize/expectedSize ];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.zcprogress.hidden  =YES;
        self.centerLabel.hidden = YES;
    }];
    [self.view bringSubviewToFront:self.saveBtn];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backword:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save:(id)sender {
    if (self.imgview.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片还没下载完"];
        return;
    }
    UIImageWriteToSavedPhotosAlbum(self.imgview.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
}
- (void)back{

    [self dismissViewControllerAnimated:YES completion:nil];

}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView;
{

    return _imgview;
}
//完成放大缩小时调用
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale;
{
    CGFloat pictureW = ZCScreenW;
    CGFloat pictureH = pictureW *self.topic.height /self.topic.width;
    if (pictureH>ZCScreenH) {
       _imgview.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollview.contentSize = CGSizeMake(pictureW, pictureH);
    }else{
       _imgview.size = CGSizeMake(pictureW, pictureH);
        _imgview.centerY = ZCScreenH*0.5;
    }
 
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
