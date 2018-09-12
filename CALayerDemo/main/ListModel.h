//
//  ListModel.h
//  CALayerDemo
//
//  Created by 杨科军 on 2018/9/11.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject

/** title*/
@property(nonatomic, copy)NSString *title;
/** 跳转的VC*/
@property(nonatomic,strong)Class targetVC;
/** 第几个*/
@property(nonatomic,assign)NSInteger index;

- (instancetype)initWithTitle:(NSString *)title andTargetVC:(Class )targetVC;
+ (instancetype)initWithTitle:(NSString *)title andTargetVC:(Class )targetVC;

@end
