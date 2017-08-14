//
//  TestTableViewCell.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/17.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "TestTableViewCell.h"

@implementation TestTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame=[UIScreen mainScreen].bounds;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.imgView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 120, 90)];
    [self addSubview:self.imgView];
    
    self.name=[[UILabel alloc] initWithFrame:CGRectMake(130, 5, kCELLWIDTH-135, 50)];
//    self.name.numberOfLines=0;
    self.name.font=[UIFont systemFontOfSize:16];
    self.name.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.name];
    
    self.department=[[UILabel alloc] initWithFrame:CGRectMake(130, 60, kCELLWIDTH-135, 35)];
    self.department.font=[UIFont systemFontOfSize:14];
    [self addSubview:self.department];
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
