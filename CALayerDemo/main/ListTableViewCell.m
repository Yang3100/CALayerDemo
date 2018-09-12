//
//  ListTableViewCell.m
//  CALayerDemo
//
//  Created by 杨科军 on 2018/9/11.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "ListTableViewCell.h"

@interface ListTableViewCell ()

@property (nonatomic, strong) UILabel  *titlelabel;
@property (nonatomic, strong) UILabel  *subTitleLabel;

@end

@implementation ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self                 = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.titlelabel      = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 290, 25)];
    self.titlelabel.font = [UIFont fontWithName:@"Chalkduster" size:15];
    [self.contentView addSubview:self.titlelabel];
    
    self.subTitleLabel           = [[UILabel alloc] initWithFrame:CGRectMake(10, 32, 290, 10)];
    self.subTitleLabel.font      = [UIFont fontWithName:@"Chalkduster" size:12];
    self.subTitleLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.subTitleLabel];
    return self;
}
- (void)setModel:(ListModel *)model{
    _model = model;
    self.titlelabel.text = [NSString stringWithFormat:@"%02ld. %@", (long)model.index, model.title];
    self.subTitleLabel.text = [NSString stringWithFormat:@"%@",[model.targetVC class]];
    if (self.indexPath.row % 2) {
        self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.05f];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
}

+(instancetype)createTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"ListCell";
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ListTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    return cell;
}

@end
