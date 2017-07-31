//
//  C_two_lsitModel.h
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/21.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface C_two_lsitModel : NSObject

@property (nonatomic,assign) int id;
@property (nonatomic,strong) NSString *name; // 名字
@property (nonatomic,strong) NSString *title; // 标题
@property (nonatomic,strong) NSString *pic; // 图片
@property (nonatomic,strong) NSString *add_name; // 添加人
@property (nonatomic,strong) NSString *date; // 添加日期
@property (nonatomic,assign) NSInteger num; // 数量

@end
