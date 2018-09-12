//
//  ListTableViewCell.h
//  CALayerDemo
//
//  Created by 杨科军 on 2018/9/11.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"

@interface ListTableViewCell : UITableViewCell

/** 数据源*/
@property(nonatomic,strong)ListModel *model;
@property(nonatomic,assign)NSIndexPath *indexPath;
+(instancetype)createTableViewCellWithTableView:(UITableView *)tableView;


@end
