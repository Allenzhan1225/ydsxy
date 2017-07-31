//
//  CoursesModel.h
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/21.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoursesModel : NSObject

@property (nonatomic,assign) int id;// 课程id
@property (nonatomic,strong) NSString *name;// 课程名字
@property (nonatomic,assign) int c_type_1;// 课程分类  1 为 自选  学员可以自行报名  2 为安排 学员为安排内定学员  没有报名点击菜单
@property (nonatomic,strong) NSString *docent_name;// 讲师姓名
@property (nonatomic,strong) NSString *s_date;// 课程开始时间
@property (nonatomic,strong) NSString *n_date;// 课程结束时间
@property (nonatomic,strong) NSString *pic;// 图片名字
@property (nonatomic,assign) int status;// 报名状态，1 为已报名
@property (nonatomic,strong) NSString *obj_id; // 报名人数
@property (nonatomic,strong) NSString *introduce;

-(instancetype)initWithID:(int)id withName:(NSString *)name withIntroduce:(NSString *)introduce withC_type_1:(int)c_type_1 withDocent_name:(NSString *)docent_name withS_date:(NSString *)s_date withN_date:(NSString *)n_date withPic:(NSString *)pic withStatus:(int)status withObj_id:(NSString *)obj_id;

@end
