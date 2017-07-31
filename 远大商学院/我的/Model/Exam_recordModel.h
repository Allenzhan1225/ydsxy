//
//  Exam_recordModel.h
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/3.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Exam_recordModel : NSObject

@property (nonatomic,assign) int id; // id
@property (nonatomic,assign) int u_id; // 所属部门编号
@property (nonatomic,strong) NSString *t_p_name; // 名字
@property (nonatomic,assign) int sum_score; // 总分
@property (nonatomic,assign) int pass_score; // 及格分数
@property (nonatomic,assign) int fact_score; // 实际得分
@property (nonatomic,assign) int exam_time; // 考试计时
@property (nonatomic,assign) int fact_time; // 实际用时
@property (nonatomic,strong) NSString *read_over_lecturer; // 批阅讲师
@property (nonatomic,strong) NSString *read_over_date; // 批阅日期
@property (nonatomic,strong) NSString *date; // 考试日期

@end
