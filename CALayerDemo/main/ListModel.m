//
//  ListModel.m
//  CALayerDemo
//
//  Created by 杨科军 on 2018/9/11.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

- (instancetype)initWithTitle:(NSString *)title andTargetVC:(Class )targetVC{
    self = [super init];
    if (self) {
        _title = title;
        _targetVC = targetVC;
    }
    return self;
}
+ (instancetype)initWithTitle:(NSString *)title andTargetVC:(Class )targetVC{
    ListModel *model = [[ListModel alloc]initWithTitle:title andTargetVC:targetVC];
    return model;
}


@end
