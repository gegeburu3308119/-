//
//  ZCMeFootView.m
//  大葱内涵
//
//  Created by 张聪 on 16/5/10.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import "ZCMeFootView.h"
#import "ZCMeBtnModel.h"
#import "ZCMebutton.h"
@interface ZCMeFootView ()
@property (nonatomic,strong)NSMutableArray *dataArr;
@end
@implementation ZCMeFootView
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;

}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php"  parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSArray *arr = responseObject[@"square_list"];
            [arr enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ZCMeBtnModel * model = [[ZCMeBtnModel alloc]initWithDic:obj];
                [self.dataArr addObject:model];
            }];
            [self createSquares:_dataArr];
            [self setNeedsLayout];
            if (self.compelte) {
                self.compelte();
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
        
    }
    return self;

}
-(void)createSquares:(NSArray*)sqaures{
    int maxCols = 4;
    CGFloat buttonW = ZCScreenW / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i<sqaures.count; i++) {
        ZCMebutton * btn = [ZCMebutton buttonWithType:UIButtonTypeCustom];
        [btn  addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.model = _dataArr[i];
        [self addSubview:btn];
        
        int col = i%maxCols;
        int row = i/maxCols;
        
        btn.x = col * buttonW;
        btn.y = row * buttonH;
        btn.width = buttonW;
        btn.height = buttonH;
        
    }
    NSInteger rows = (_dataArr.count + maxCols -1)/maxCols;
    self.height = rows *buttonH;
    [self setNeedsDisplay];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshTable" object:nil];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)click:(ZCMebutton*)sender{





}
@end
