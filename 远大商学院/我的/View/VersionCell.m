//
//  VersionCell.m
//  远大商学院
//
//  Created by YDWY on 16/8/5.
//  Copyright © 2016年 YDWY. All rights reserved.
//

#import "VersionCell.h"

@implementation VersionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame=[UIScreen mainScreen].bounds;
        [self buildUI];
    }
    return self;
}

- (void)buildUI{
    _titleName=[[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 44)];
    [self addSubview:_titleName];
    
    _version=[[UILabel alloc] initWithFrame:CGRectMake(kCELLWIDTH-50, 0, 40, 44)];
    _version.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_version];
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
