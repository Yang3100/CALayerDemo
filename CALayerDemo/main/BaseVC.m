//
//  BaseVC.m
//  CALayerDemo
//
//  Created by 杨科军 on 2018/9/11.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addbackBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    NSLog(@"%@--dealloc",NSStringFromClass([self class]));
}
/**
 添加返回
 */
- (void)addbackBtn {
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [backBtn setImage:[UIImage imageNamed:@"navigationBack"] forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(onClickBack:) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}


#pragma mark -Action
- (void)onClickBack:(UIButton*)back {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
