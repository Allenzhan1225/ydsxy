//
//  C_two_lisTableViewCell.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/7.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "C_two_lisTableViewCell.h"

@implementation C_two_lisTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame=[UIScreen mainScreen].bounds;
        [self buildUI];
    }
    return self;
}

- (void)buildUI{
    self.imgView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 120, 90)];
    [self addSubview:self.imgView];
    
    // 名字
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(130, 3, 40, 30)];
    titleLabel.text=@"课题:";
    [self addSubview:titleLabel];
    _title=[[UILabel alloc] initWithFrame:CGRectMake(175, 3, kCELLWIDTH-180, 30)];
    [self addSubview:_title];
    
    // 点击数
    UILabel *numLabel=[[UILabel alloc] initWithFrame:CGRectMake(130, 35, 60, 30)];
    numLabel.text=@"点击数:";
    [self addSubview:numLabel];
    _num=[[UILabel alloc] initWithFrame:CGRectMake(195, 35, kCELLWIDTH-200, 30)];
    [self addSubview:_num];
    
    // 添加日期
    UILabel *dateLabel=[[UILabel alloc] initWithFrame:CGRectMake(130, 67, 80, 30)];
    dateLabel.text=@"添加时间:";
    [self addSubview:dateLabel];
    dateLabel.font = [UIFont systemFontOfSize:14];
    dateLabel.adjustsFontSizeToFitWidth = YES;
    _date=[[UILabel alloc] initWithFrame:CGRectMake(215, 67, kCELLWIDTH-220, 30)];
    _date.font = [UIFont systemFontOfSize:14];
    _date.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_date];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
