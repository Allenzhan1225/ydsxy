//
//  CompanyMessageCell.h
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/19.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyMessageCell : UITableViewCell

@property (nonatomic,strong) UILabel *titelLabel;
@property (nonatomic,strong) UILabel *contentlLabel; // 内容只能在详情界面查看
@property (nonatomic,strong) UILabel *add_date;
@property (nonatomic,strong) UIImageView *imgView;

@end
