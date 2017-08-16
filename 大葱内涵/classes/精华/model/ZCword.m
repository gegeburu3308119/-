//
//  ZCword.m
//  大葱内涵
//
//  Created by 张聪 on 16/5/4.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import "ZCword.h"

@implementation ZCword
-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }

    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"image0"]) {
        self.small_image = value;
    }else if ([key isEqualToString:@"image1"]){
        self.large_image = value;
    
    }else if ([key isEqualToString:@"image2"]){
        self.middle_image = value;
       
    }else if ([key isEqualToString:@"id"]){
        self.ID  = value;
    
    }


}
-(id)valueForUndefinedKey:(NSString *)key{
    return nil;

}
//-(void)setCreate_time:(NSString *)create_time{
//    _create_time = create_time;
//    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    NSDate *create = [fmt dateFromString:_create_time];
//    
//    
//
//
//
//}
- (CGFloat)cellHeight{
  
    // 文字的最大尺寸
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, MAXFLOAT);
    //    CGFloat textH = [topic.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:maxSize].height;
    CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
    
    // cell的高度
    CGFloat cellH = 55 + textH +44 + 2 * 10;
    if (self.type == XMGTopicTypePicture) {
        if (self.width != 0&&self.height!= 0) {
            CGFloat pictureW = maxSize.width;
            CGFloat pictureH = pictureW *self.height/self.width;
            if (pictureH >=1000) { // 图片高度过长
                pictureH = 250;
                self.bigPicture = YES; // 大图
            }
            CGFloat pictureX = 10;
            CGFloat pictureY = 55 + textH + 10;
             _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            cellH +=  pictureH+10;
        }
    }else if (self.type == XMGTopicTypeVideo){
        CGFloat videoX = 10;
        CGFloat videoY = 55 +textH+10;
        CGFloat videoW = maxSize.width;
        CGFloat videoH = videoW*self.height/self.width;
        _videoF = CGRectMake(videoX, videoY, videoW, videoH);
        cellH += videoH+10;
    
    
    }
    return cellH;
}
@end
