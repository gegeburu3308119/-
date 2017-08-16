//
//  ZCword.h
//  大葱内涵
//
//  Created by 张聪 on 16/5/4.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCword : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像的URL */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
/** 是否为新浪加V用户 */
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;
/** 最热评论 */
@property (nonatomic, assign) XMGTopicType type;
/** 小图片的URL */
@property (nonatomic, copy) NSString *small_image;
/** 中图片的URL */
@property (nonatomic, copy) NSString *middle_image;
/** 大图片的URL */
@property (nonatomic, copy) NSString *large_image;
/** 帖子的类型 */
@property (nonatomic, copy) NSString*videouri;//视频地址
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;;
- (CGFloat)cellHeight;
@property (nonatomic, assign) CGRect pictureF;
@property (nonatomic, assign) CGRect videoF;
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
-(instancetype)initWithDic:(NSDictionary*)dic;
@property (nonatomic, assign) CGFloat pictureProgress;

@end
