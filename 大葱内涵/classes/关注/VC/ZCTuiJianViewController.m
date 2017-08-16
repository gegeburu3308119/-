//
//  ZCTuiJianViewController.m
//  大葱内涵
//
//  Created by 张聪 on 16/4/29.
//  Copyright © 2016年 张聪. All rights reserved.
//

#import "ZCTuiJianViewController.h"
#import "Biaoqian.h"
#import "ZCBiaoQianTableViewCell.h"
#import "GuanzhuMoel.h"
#import "ZCguanzhuUserCell.h"
@interface ZCTuiJianViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *guanzhuTableView;
@property (weak, nonatomic) IBOutlet UITableView *BiaoQianTableView;
@property (nonatomic,strong)NSMutableArray *bianqianArray;//标签
@property (nonatomic,strong)NSMutableArray* rightArray;
@end

@implementation ZCTuiJianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐关注";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.BiaoQianTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.guanzhuTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
  
    
    self.view.backgroundColor = ZCGLObalColor;
    self.guanzhuTableView.backgroundColor = ZCGLObalColor;
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"a"] = @"category";
    dic[@"c"] = @"subscribe";
    self.BiaoQianTableView.tableFooterView = [[UIView alloc]init];
    self.guanzhuTableView.tableFooterView = [[UIView alloc]init];
    self.guanzhuTableView.delegate = self;
    self.guanzhuTableView.dataSource =self;
    [self.BiaoQianTableView registerNib:[UINib nibWithNibName:@"ZCBiaoQianTableViewCell" bundle:nil] forCellReuseIdentifier:@"biaoqian"];
    [self.guanzhuTableView registerNib:[UINib nibWithNibName:@"ZCguanzhuUserCell" bundle:nil ]forCellReuseIdentifier:@"user"] ;
    self.BiaoQianTableView.backgroundColor = [UIColor clearColor];
    
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.rightArray removeAllObjects];
        [SVProgressHUD dismiss];
        ZCLog(@"%@",responseObject);
        NSArray *dataArr = responseObject[@"list"];
        self.bianqianArray = [NSMutableArray array];
        
        [dataArr enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            Biaoqian *biaoqian = [[Biaoqian alloc]init];
            biaoqian.ID = [dic[@"id"] integerValue];
            biaoqian.count =[dic[@"count"] integerValue];
            biaoqian.name = dic[@"name"];
            [_bianqianArray addObject:biaoqian];
            
        }];
        
        [self.BiaoQianTableView reloadData];
        [self.BiaoQianTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        [self tableView:self.BiaoQianTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败"];
    }];
      [self setuprefresh];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)setuprefresh{
    self.guanzhuTableView.header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(news)];//加载更多数据
    self.guanzhuTableView.footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreloads)];//加载更多数据

}
-(void)news{

ZCLog(@"oh shit");

}
-(void)moreloads{


    ZCLog(@"shit");

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray *)rightArray{
    if (!_rightArray) {
        _rightArray = [NSMutableArray array];
    }
    return _rightArray;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.BiaoQianTableView) {
        return _bianqianArray.count;
    }else{
        Biaoqian* b = self.bianqianArray[self.BiaoQianTableView.indexPathForSelectedRow.row];
        return b.users.count;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.BiaoQianTableView) {
        ZCBiaoQianTableViewCell *cell = [self.BiaoQianTableView dequeueReusableCellWithIdentifier:@"biaoqian"];
        cell.biaoqian = _bianqianArray[indexPath.row];
        return cell;
    }else{
    
    ZCguanzhuUserCell *cell = [self.guanzhuTableView dequeueReusableCellWithIdentifier:@"user"];
//   long a = [self.guanzhuTableView indexPathForSelectedRow].row;
    Biaoqian* b = self.bianqianArray[self.BiaoQianTableView.indexPathForSelectedRow.row];
    cell.model = b.users[indexPath.row];
    return cell;
    }
   

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.BiaoQianTableView) {
        return 50;
    }else{
        return 80 ;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.BiaoQianTableView) {
        Biaoqian *b = self.bianqianArray[indexPath.row];
        if (b.users.count) {
            [self.guanzhuTableView reloadData];
        }else{
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(b.ID);
        [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            [self.rightArray removeAllObjects];
            ZCLog(@"%@",responseObject);
            
            NSArray *dataArr = responseObject[@"list"];
            
            [dataArr enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
                GuanzhuMoel * model = [[GuanzhuMoel alloc]initWithdic:dic];
                [self.rightArray addObject:model];
                
            }];
          
            if (!b.users) {
                b.users = [NSMutableArray array];
            }
            [b.users addObjectsFromArray:self.rightArray];
          
            [self.guanzhuTableView reloadData];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];

    }
    }
}
@end
