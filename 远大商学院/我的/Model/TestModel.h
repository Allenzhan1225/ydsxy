//
//  TestModel.h
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/4.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestModel : NSObject

@property (nonatomic,assign) int id; //试卷id
@property (nonatomic,assign) int d_id; //部门id
@property (nonatomic,assign) int add_id; //试卷添加人id
@property (nonatomic,assign) int sum_score; //总分
@property (nonatomic,assign) int pass_score; // 及格分
@property (nonatomic,assign) int exam_time; // 考试时间
@property (nonatomic,retain) NSString *name; //试卷名称
@property (nonatomic,retain) NSString *pic; //封面图片 //peixun.xgyuanda.com/Public/uploads/test_paper/middle_(55efa73e0a101.jpg)
@property (nonatomic,retain) NSString *add_date; // 添加时间

@end
