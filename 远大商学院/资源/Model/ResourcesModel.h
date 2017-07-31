//
//  ResourcesModel.h
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/20.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResourcesModel : NSObject

@property (nonatomic,assign) int id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *level;
@property (nonatomic,strong) NSString *pic;
@property (nonatomic,strong) NSString *add_name;
@property (nonatomic,strong) NSString *add_id;
@property (nonatomic,strong) NSString *add_date;
// 数量
@property (nonatomic,assign) int num;
// 点击量
@property (nonatomic,assign) int click;

@end
