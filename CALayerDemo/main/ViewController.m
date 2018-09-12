//
//  ViewController.m
//  CALayerDemo
//
//  Created by 杨科军 on 2018/9/11.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "ViewController.h"
#import "ListModel.h"
#import "BaseVC.h"
#import "ListTableViewCell.h"

#import "CAShapeLayerVC.h"
#import "CATiledLayerVC.h"

#define MainSize [UIScreen mainScreen].bounds.size
//导航栏高度
#define AINavgationBarH 64
#define AITabbarH 49

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 主要的tableView*/
@property(nonatomic,strong)UITableView *tableView;
/** 数据源*/
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,assign,getter=isTableViewLoadData)BOOL tableViewLoadData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"😎CALayer子类";
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    [self setUI];
}

#pragma mark ----lazy
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        NSArray *array = @[[ListModel initWithTitle:@"绘制立体的贝塞尔曲线" andTargetVC:[CAShapeLayerVC class]],
                           [ListModel initWithTitle:@"用来管理一副可以被分割的大图" andTargetVC:[CATiledLayerVC class]]
                           ];
        
        _dataSource = [NSMutableArray arrayWithCapacity:array.count];
        for (int i = 0; i < array.count; i++) {
            ListModel *model = array[i];
            model.index      = i+1;
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}



#pragma mark ----UI
/**设置ui*/
-(void)setUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, AINavgationBarH,MainSize.width , MainSize.height-AINavgationBarH) style:(UITableViewStylePlain)];
    //去掉自带分割线
    [_tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Load data.
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (int i = 0; i < self.dataSource.count; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:0]];
    }
    self.tableViewLoadData = YES;
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 立即取消选中
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    ListModel *model             = self.dataSource[indexPath.row];
    BaseVC *targetVC = [[model.targetVC alloc]init];
    targetVC.title                 = model.title;
    [self.navigationController pushViewController:targetVC animated:YES];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.isTableViewLoadData ? self.dataSource.count:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTableViewCell *cell = [ListTableViewCell createTableViewCellWithTableView:tableView];
    cell.indexPath            = indexPath;
    cell.model                = self.dataSource[indexPath.row];
    return cell;
}

@end
