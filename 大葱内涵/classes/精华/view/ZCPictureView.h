//
//  ZCPictureView.h
//  大葱内涵
//
//  Created by 张聪 on 16/5/5.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCword.h"
@interface ZCPictureView : UIView

@property (weak, nonatomic) IBOutlet UIButton *openBTn;
@property (weak, nonatomic) IBOutlet UIImageView *gifImg;
@property (weak, nonatomic) IBOutlet UIImageView *contentView;
@property (nonatomic,strong)ZCword *topic;
+(instancetype)picTureView;
@end
