//
//  RecentClassPlanTableViewCell.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/26.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "RecentClassPlanTableViewCell.h"

@implementation RecentClassPlanTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame=[UIScreen mainScreen].bounds;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _picImgView=[[UIImageView alloc] initWithFrame:CGRectMake(2, 7, 106, 96)];
    [self addSubview:_picImgView];
    
    _name=[[UILabel alloc] initWithFrame:CGRectMake(110, 5, kCELLWIDTH-115, 30)];
    _name.font = [UIFont systemFontOfSize:13];
    _name.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_name];
    
    UILabel *docent_nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(110, 40, 60, 30)];
    docent_nameLabel.text=@"演讲人:";
    docent_nameLabel.font = [UIFont systemFontOfSize:13];
    
    _docent_name=[[UILabel alloc] initWithFrame:CGRectMake(175, 40, 60, 30)];
    _docent_name.font = [UIFont systemFontOfSize:13];
    _docent_name.adjustsFontSizeToFitWidth = YES;
    [self addSubview:docent_nameLabel];
    [self addSubview:_docent_name];
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
