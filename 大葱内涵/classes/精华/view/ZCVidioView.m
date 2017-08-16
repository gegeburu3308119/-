//
//  ZCVidioView.m
//  大葱内涵
//
//  Created by 张聪 on 16/5/6.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import "ZCVidioView.h"
#import "FMGVideoPlayView.h"
@interface ZCVidioView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UIButton *playbtn;
@property (weak, nonatomic) FMGVideoPlayView*fmgVideoView;
@property (weak, nonatomic) IBOutlet UILabel *cishulabel;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;
@property (strong, nonatomic) UIWindow *videoWin;
@end
@implementation ZCVidioView

- (UIWindow *)videoWin{
    
    if (!_videoWin) {
        _videoWin = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _videoWin;
}
+(instancetype)videoView{

    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];


}
-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    UITapGestureRecognizer *tap =[[ UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.imageview addGestureRecognizer:tap];


}
-(void)tap:(UITapGestureRecognizer*)sender{

 
//    UIViewController *vc = [[UIViewController alloc] init];
//    self.videoWin.rootViewController = vc;
//    playerVC.url = self.topic.videouri;
//    playerVC.playFinished = ^(){
//        self.videoWin.rootViewController = nil;
//        [keyWin makeKeyAndVisible];
//    };
//    [self.videoWin makeKeyAndVisible];
//    [vc presentViewController:playerVC animated:YES completion:nil];



}
-(void)setTopic:(ZCword *)topic{
    _topic = topic;
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil];
    self.cishulabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    NSInteger minute = topic.videotime/60;
    NSInteger second = topic.videotime%60;
    self.imageview.contentMode = UIViewContentModeScaleAspectFill;
//  self.imageview.contentMode = UIViewContentModeScaleToFill;
    self.timelabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
   
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
