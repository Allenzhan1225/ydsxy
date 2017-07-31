//
//  DataBase.h
//  SQLite数据库
//
//  Created by admin on 15/10/27.
//  Copyright © 2015年 C. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CoursesModel;

@interface DataBase : NSObject

// 创建单例
+ (DataBase *)shareDataBase;

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
