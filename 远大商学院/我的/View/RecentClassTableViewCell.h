//
//  RecentClassTableViewCell.h
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/22.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecentClassTableViewCell : UITableViewCell

/**
 *  课程信息
 */
@property (nonatomic,strong) UIButton *btn;
@property (nonatomic,retain) UILabel *name;
@property (nonatomic,retain) UIImageView *picImgView;
@property (nonatomic,retain) UILabel *docent_name;
@property (nonatomic,retain) UILabel *obj_id;
@property (nonatomic,retain) UILabel *enrollLabel;

@end
