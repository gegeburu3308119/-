//
//  ZCPictureView.m
//  大葱内涵
//
//  Created by 张聪 on 16/5/5.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import "ZCPictureView.h"
#import "ZCShowPicTureController.h"
@implementation ZCPictureView
+(instancetype)picTureView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];;

}
-(void)awakeFromNib{

    self.autoresizingMask = UIViewAutoresizingNone;
    self.contentView.userInteractionEnabled = YES;
    [self.contentView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicTure)]];
    

}
-(void)showPicTure{
    ZCShowPicTureController *picV = [[ZCShowPicTureController alloc]init];
    picV.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:picV animated:YES completion:nil];

}
- (IBAction)click:(id)sender {
    ZCShowPicTureController *picV = [[ZCShowPicTureController alloc]init];
    picV.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:picV animated:YES completion:nil];
}
-(void)setTopic:(ZCword *)topic{
    _topic = topic;
   [self.contentView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       if (topic.isBigPicture == NO)return ;
       UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0.0);
       CGFloat width = topic.pictureF.size.width;
       CGFloat height = width*image.size.height /image.size.width;
       [image drawInRect:CGRectMake(0, 0, width, height)];
       
       self.contentView.image = UIGraphicsGetImageFromCurrentImageContext();
       UIGraphicsEndImageContext();
       
    }];
    NSString * extenshion = topic.large_image.pathExtension;
    self.gifImg.hidden = ![extenshion.lowercaseString isEqualToString:@"gif"];
    
    // 判断是否显示"点击查看全图"
    if (topic.isBigPicture) { // 大图
      
        self.contentView.contentMode = UIViewContentModeScaleAspectFill;
        self.openBTn.hidden = NO;
        self.contentView.layer.masksToBounds = YES;
        
    } else { // 非大图
        self.openBTn.hidden = YES;
        self.contentView.contentMode = UIViewContentModeScaleToFill;
        
    }
 

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
