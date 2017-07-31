//
//  RecentClassTableViewCell.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/22.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "RecentClassTableViewCell.h"

@implementation RecentClassTableViewCell

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
    docent_nameLabel.font = [UIFont systemFontOfSize:13];
    docent_nameLabel.text=@"演讲人:";
    _docent_name=[[UILabel alloc] initWithFrame:CGRectMake(175, 40, 60, 30)];
     _docent_name.adjustsFontSizeToFitWidth = YES;
    _docent_name.font = [UIFont systemFontOfSize:13];
    [self addSubview:docent_nameLabel];
    [self addSubview:_docent_name];
    
    _enrollLabel=[[UILabel alloc] initWithFrame:CGRectMake(240, 40, 60, 30)];
    _enrollLabel.font = [UIFont systemFontOfSize:13];
    _enrollLabel.adjustsFontSizeToFitWidth= YES;
    _enrollLabel.text=@"已报名:";

    [self addSubview:_enrollLabel];
    _obj_id=[[UILabel alloc] initWithFrame:CGRectMake(295, 40, kCELLWIDTH-300, 30)];
    _obj_id.font = [UIFont systemFontOfSize:13];
    _obj_id.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_obj_id];
    
    _btn=[UIButton buttonWithType:UIButtonTypeCustom];
    _btn.layer.cornerRadius= 8;
    _btn.layer.masksToBounds = YES;
    _btn.frame=CGRectMake(115, 75, 115+(kCELLWIDTH-120)/2-30, 30);
    [self addSubview:_btn];
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
