//
//  ResourceTableViewCell.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/14.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "ResourceTableViewCell.h"

@implementation ResourceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame=[UIScreen mainScreen].bounds;
        [self initview];
    }
    return self;
}

- (void)initview{
    _imgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholds"]];
    _imgView.frame=CGRectMake(5, 5, 120, 90);
    [self addSubview:_imgView];
    
    UILabel *kind_label=[[UILabel alloc] initWithFrame:CGRectMake(130, 5, 40, 30)];
    kind_label.text=@"种类:";
    [self addSubview:kind_label];
    
    _kinds=[[UILabel alloc] initWithFrame:CGRectMake(175, 5, kCELLWIDTH-150, 30)];
    [self addSubview:_kinds];
    
    UILabel *numb_label=[[UILabel alloc] initWithFrame:CGRectMake(130, 50, 80, 30)];
    numb_label.text=@"点击人数:";
    [self addSubview:numb_label];
    
    _numb=[[UILabel alloc] initWithFrame:CGRectMake(215, 50, kCELLWIDTH-200, 30)];
    [self addSubview:_numb];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
