//
//  QuestionnaireModel.h
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/28.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionnaireModel : NSObject

@property (nonatomic,assign) int id; // 问卷id
@property (nonatomic,strong) NSString *name;  // 问卷标题
@property (nonatomic,assign) int department; // 部门
@property (nonatomic,assign) int type; //  需求
@property (nonatomic,strong) NSString *add_u_name; // 添加人
@property (nonatomic,strong) NSString *add_date; // 添加日期
@property (nonatomic,assign) int is_join; // 是否参加过
@property (nonatomic,assign) int state;
@property (nonatomic,assign) int status;

@end
