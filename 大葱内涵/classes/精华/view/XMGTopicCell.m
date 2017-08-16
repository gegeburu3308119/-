//
//  XMGTopicCell.m
//  01-百思不得姐
//
//  Created by xiaomage on 15/7/27.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGTopicCell.h"
#import "ZCword.h"
#import "UIImageView+WebCache.h"
#import "ZCVidioView.h"
@interface XMGTopicCell()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

/** 内容 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/** 新浪加V */
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
@property (strong, nonatomic) ZCPictureView *pic;
@property (strong,nonatomic)ZCVidioView *videoView;
@end

@implementation XMGTopicCell

- (ZCPictureView *)pic{
    if (!_pic) {
         ZCPictureView *pic =  [ZCPictureView picTureView];
        [self.contentView addSubview:pic];
        _pic = (ZCPictureView*)pic;
    }
    return _pic;


}
- (ZCVidioView *)videoView{
    if (!_videoView) {
        ZCVidioView *videov =  [ZCVidioView videoView];
        [self.contentView addSubview:videov];
        _videoView =videov;
    }
    return _videoView;
    
    
}
- (void)awakeFromNib
{  self.autoresizingMask = UIViewAutoresizingNone;
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setTopic:(ZCword *)topic
{
    _topic = topic;
    self.videoView.hidden = YES;
    self.pic.hidden = YES;
    // 新浪加V
    self.sinaVView.hidden = !topic.isSina_v;
    
    // 设置头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.contentLabel.text = topic.text;
    // 设置名字
    self.nameLabel.text = topic.name;
    
    // 设置帖子的创建时间
    self.createTimeLabel.text = topic.create_time;
    
    // 设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    if (topic.type == XMGTopicTypePicture) {
        self.pic.hidden = NO;
        self.pic.topic = topic;
        self.pic.frame = topic.pictureF;
    }else if(topic.type == XMGTopicTypeVideo){
        self.videoView.hidden = NO;
        self.videoView.topic =topic;
        self.videoView.frame = topic.videoF;
    
    }
    
}

/**
 * 设置底部按钮文字
 */
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}
- (IBAction)more:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏", @"举报", nil];
    [sheet showInView:self.window];
    
    
}

#pragma mark - <UIActionSheetDelegate>
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex

{
    
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2) return;
    
    [SVProgressHUD showErrorWithStatus:@"请先登录"];
    
    // 开始执行举报\收藏操作
}
- (void)setFrame:(CGRect)frame
{
    static CGFloat margin = 10;
    
    frame.origin.x = margin;
    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}

@end
