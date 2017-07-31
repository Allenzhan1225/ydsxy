//
//  LastestNewsCell.m
//  远大商学院
//
//  Created by YDWY on 16/7/30.
//  Copyright © 2016年 YDWY. All rights reserved.
//

#import "LastestNewsCell.h"

@implementation LastestNewsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame=[UIScreen mainScreen].bounds;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _imgView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 100, 75)];
    [self addSubview:_imgView];
    
//    if (self.heigth > 55) {
//        self.heigth = 55;
//    }
    
    _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(110, 15, kCELLWIDTH-115, 55)];
    _titleLabel.font=[UIFont systemFontOfSize:14];
   // _titleLabel.textColor = [UIColor colorWithRed:(222%256)/255.0 green:(222%256)/255.0  blue:(222%256)/255.0  alpha:1];
    _titleLabel.numberOfLines=0;
    [self addSubview:_titleLabel];
}

-(void)setHeigth:(CGFloat)heigth{
    _titleLabel.frame = CGRectMake(110, 15, kCELLWIDTH-115, self.heigth);
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
