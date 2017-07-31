//
//  CompanyMessageCell.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/19.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "CompanyMessageCell.h"

@implementation CompanyMessageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame=[[UIScreen mainScreen] bounds];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _imgView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 90, 90)];
    _imgView.image=[UIImage imageNamed:@"logo"];
    [self addSubview:_imgView];
    
    _titelLabel=[[UILabel alloc] initWithFrame:CGRectMake(100, 0, kCELLWIDTH-105, 40)];
    _titelLabel.textColor=[UIColor redColor];
    _titelLabel.font=[UIFont systemFontOfSize:24];
    _titelLabel.textAlignment=NSTextAlignmentLeft;
    _titelLabel.numberOfLines=0;
    [self addSubview:_titelLabel];
    
    UILabel *contentLabel=[[UILabel alloc] initWithFrame:CGRectMake(100, 40, 40, 30)];
    contentLabel.text=@"内容:";
    [self addSubview:contentLabel];
    _contentlLabel=[[UILabel alloc] initWithFrame:CGRectMake(140, 40, kCELLWIDTH-150, 30)];
    [self addSubview:_contentlLabel];
    
    UILabel *dateLabel=[[UILabel alloc] initWithFrame:CGRectMake(100, 70, 60, 30)];
    dateLabel.text=@"发布日期:";
    dateLabel.numberOfLines=0;
    dateLabel.font=[UIFont systemFontOfSize:13];
    [self addSubview:dateLabel];
    _add_date=[[UILabel alloc] initWithFrame:CGRectMake(160, 70, kCELLWIDTH-165, 30)];
    _add_date.font=[UIFont systemFontOfSize:13];
    [self addSubview:_add_date];
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
