//
//  HistoryDataBase.h
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/6/2.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CoursesModel;

@interface HistoryDataBase : NSObject

// 创建单例
+ (HistoryDataBase *)shareDataBase;

// 创建打开数据库的方法
- (void)openDB;

//关闭数据库的方法
- (void)closeDB;

// 增加
- (void)insertCourses:(CoursesModel *)course;

//删除
- (void)deleteCoursesWithCourseID:(int)courseID;

// 查询所有
- (NSArray *)selectAllCourses;

// 查询某个
- (CoursesModel *)selectCoursesCoursesID:(int)coursesID;

@end
