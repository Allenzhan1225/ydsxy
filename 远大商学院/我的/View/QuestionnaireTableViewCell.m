//
//  QuestionnaireTableViewCell.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/28.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "QuestionnaireTableViewCell.h"

@implementation QuestionnaireTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame=[UIScreen mainScreen].bounds;
        [self buildUI];
    }
    return self;
}

- (void)buildUI{
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 40)];
    title.text=@"名称:";
    title.font=[UIFont systemFontOfSize:20];
    [self addSubview:title];
    
    self.titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(65, 10, kCELLWIDTH-65, 40)];
    self.titleLabel.font=[UIFont systemFontOfSize:20];
    self.titleLabel.textColor=[UIColor blueColor];
    [self addSubview:self.titleLabel];
    
    // 参见问卷按钮
    self.attendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.attendBtn.frame=CGRectMake(10, 55, 100, 30);
    // 设置边框、圆角
    self.attendBtn.layer.borderColor=[[UIColor blackColor] CGColor];
    self.attendBtn.layer.borderWidth=1.0f;
    self.attendBtn.layer.masksToBounds=YES;
    self.attendBtn.layer.cornerRadius=8;
    
    [self.attendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.attendBtn setTitle:@"参见问卷" forState:UIControlStateNormal];
    [self addSubview:self.attendBtn];
    
    // 查看详情按钮
    self.detailBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.detailBtn.frame=CGRectMake(120, 55, 100, 30);
    // 设置边框、圆角
    self.detailBtn.layer.borderColor=[[UIColor blackColor] CGColor];
    self.detailBtn.layer.borderWidth=1.0f;
    self.detailBtn.layer.masksToBounds=YES;
    self.detailBtn.layer.cornerRadius=8;
    
    [self.detailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.detailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    [self addSubview:self.detailBtn];
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
