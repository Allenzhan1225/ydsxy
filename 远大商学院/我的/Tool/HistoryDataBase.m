//
//  HistoryDataBase.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/6/2.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "HistoryDataBase.h"
#import <sqlite3.h>
#import "CoursesModel.h"

@implementation HistoryDataBase

// 初始化单例
static HistoryDataBase * historyDataBase=nil;

+ (HistoryDataBase *)shareDataBase{
    // 加锁(多线程时，只允许单个线程操作)
    @synchronized(self) {
        if (historyDataBase==nil) {
            historyDataBase=[[HistoryDataBase alloc] init];
            // 单例创建的时候，希望打开数据库
            [historyDataBase openDB];
        }
    }
    return historyDataBase;
}

// 创建数据库对象
static sqlite3 *db=nil;

// 创建打开数据库的方法
- (void)openDB{
    // 如果数据库已经打开，则不需要执行后面的语句，直接返回
    if (db != nil) {
        return;
    }
    
    //创建存放数据库的路径
    NSString *documentPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path=[documentPath stringByAppendingString:@"/HistoryList.sqlite"];
    // 打印地址
//    NSLog(@"%@",documentPath);
    // 打开数据库(如果改数据库不存在，直接打开，否则，新创建一个)
    int result=sqlite3_open([path UTF8String], &db);
    
    if (result==SQLITE_OK) {
        NSLog(@"数据库打开成功");
        //准备sql语句
//        NSString *sql=@"CREATE TABLE HistoryList (ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL, c_type_1 INTEGER NOT NULL, docent_name TEXT NOT NULL, s_date TEXT NOT NULL, n_date TEXT NOT NULL, pic TEXT NOT NULL, status INTEGER NOT NULL, obj_id TEXT NOT NULL, introduce TEXT NOT NULL);";
        NSString *sql=@"CREATE TABLE HistoryList (ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL, c_type_1 INTEGER NOT NULL, docent_name TEXT NOT NULL, s_date TEXT NOT NULL, n_date TEXT NOT NULL, pic TEXT NOT NULL, status INTEGER NOT NULL, obj_id TEXT NOT NULL, introduce TEXT NOT NULL);";
        // 执行sql语句
        sqlite3_exec(db, [sql UTF8String], NULL, NULL, NULL);
    }else{
        NSLog(@"%d",result);
    }
}

//关闭数据库的方法
- (void)closeDB{
    
    int result=sqlite3_close(db);
    if (result==SQLITE_OK) {
        NSLog(@"数据库关闭成功");
        //关闭数据库时，需要将db置为空，因为再次开启数据库时，需要使用db是否等于nil的判断。
        db=nil;
        
    }else{
        NSLog(@"数据库关闭失败:%d",result);
    }
}

//增加实现方法
- (void)insertCourses:(CoursesModel *)course{
    // 1.打开数据库
    [self openDB];
    // 2.创建跟随指针（伴随指针）-- 保存操作信息
    sqlite3_stmt *stmt=nil;
    // 3.准备sql语句 //CourseID,name,c_type_1,docent_name,s_date,pic,status,obj_id
    NSString *sql=@"INSERT INTO  HistoryList (ID,name,c_type_1,docent_name,s_date,n_date,pic,status,obj_id,introduce) VALUES (?,?,?,?,?,?,?,?,?,?)"; // ?的作用是占位，因为需要添加的数据时不固定的。
    // 4.验证sql是否正确
    int result=sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL); // -1表示不限长度
    if (result==SQLITE_OK) {
        NSLog(@"插入成功");
#pragma mark -- sqlite3_bind_int(<#sqlite3_stmt *#>, <#int#>, <#int#>)-- 第一个参数是跟随指针，第二个参数是顺序（顺序是从1开始计算！！！），第三个参数是需要绑定的值
        // 5.如果sql语句正确，我们就开始绑定数据，替换问号(?)
        sqlite3_bind_int(stmt, 1, course.id);
        sqlite3_bind_text(stmt, 2, [course.name UTF8String], -1, NULL); // 第三个参数的-1表示长度不限
        sqlite3_bind_int(stmt, 3, course.c_type_1);
        sqlite3_bind_text(stmt, 4, [course.docent_name UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 5, [course.s_date UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 6, [course.n_date UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 7, [course.pic UTF8String], -1, NULL);
        sqlite3_bind_int(stmt, 8, course.status);
        sqlite3_bind_text(stmt, 9, [course.obj_id UTF8String], -1, NULL);
        // introduce
        sqlite3_bind_text(stmt, 10, [course.introduce UTF8String], -1, NULL);
//        NSLog(@"course.introduce===%@",course.introduce);
        
        // 6.单步执行sql语句
        sqlite3_step(stmt);
    }else{
        NSLog(@"插入失败:%d",result);
    }
    // 7.释放跟随指针占用的内存
    sqlite3_finalize(stmt);
}

//删除
- (void)deleteCoursesWithCourseID:(int)courseID{
    // 1.打开数据库
    [self openDB];
    // 2.创建伴随指针
    sqlite3_stmt *stmt=nil;
    // 3.准备sql语句
    NSString *sql=(courseID!=0)?@"DELETE FROM HistoryList WHERE ID=?":@"DELETE FROM HistoryList";
    // 4.验证语句是否正确
    int result=sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result==SQLITE_OK) {
        NSLog(@"删除成功");
        // 5.绑定
        sqlite3_bind_int(stmt, 1, courseID);
        // 6.单步执行
        sqlite3_step(stmt);
    }else{
        NSLog(@"删除失败");
    }
    // 7.释放
    sqlite3_finalize(stmt);
}

// 查询所有id
- (NSArray *)selectAllCourses{
    // 1.
    [self openDB];
    // 2.
    sqlite3_stmt *stmt=nil;
    // 3.准备
    NSString *sql=@"SELECT *FROM HistoryList";
    // 4.验证
    int result=sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result==SQLITE_OK) {
        //        NSLog(@"查询成功");
        // 创建可变数组,添加查询到的数据
        NSMutableArray *array=[NSMutableArray arrayWithCapacity:5];
        // 执行sql语句，取值
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            // 根据sql语句，搜索到的符合条件的数据，取出来。
            // 0代表该属性的位置（从0开始）
            int ID=sqlite3_column_int(stmt, 0);
            NSString *name=[NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 1)];
            int c_type_1=sqlite3_column_int(stmt, 2);
            NSString *docent_name=[NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 3)];
            NSString *s_date=[NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 4)];
            NSString *n_date=[NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 5)];
            NSString *pic=[NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 6)];
            int status=sqlite3_column_int(stmt, 7);
            NSString *obj_id=[NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 8)];
            NSString *introduce=[NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 9)];
            //新建对象
//            CoursesModel *course=[[CoursesModel alloc] initWithID:ID withName:name withC_type_1:c_type_1 withDocent_name:docent_name withS_date:s_date withN_date:n_date withPic:pic withStatus:status withObj_id:obj_id];
            CoursesModel *course=[[CoursesModel alloc] initWithID:ID withName:name withIntroduce:introduce withC_type_1:c_type_1 withDocent_name:docent_name withS_date:s_date withN_date:n_date withPic:pic withStatus:status withObj_id:obj_id];
            // 添加到可变数组
            [array addObject:course];
        }
        // 释放伴随指针
        sqlite3_finalize(stmt);
        // 返回数组
        return array;
        
    }else{
        NSLog(@"查询失败:%d",result);
    }
    // 释放
    sqlite3_finalize(stmt);
    return nil;
}

// 查询某个id
- (CoursesModel *)selectCoursesCoursesID:(int)coursesID{
    [self openDB];
    sqlite3_stmt *stmt=nil;
    NSString *sql=@"SELECT *FROM HistoryList WHERE ID=?";
    // 验证
    int result=sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result==SQLITE_OK) {
        //        NSLog(@"查询成功");
        // 绑定
        sqlite3_bind_int(stmt, 1, coursesID);
        //
        CoursesModel *course=[CoursesModel new];
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            // 取值
            int ID=sqlite3_column_int(stmt, 0);
            NSString *name=[NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 1)];
            int c_type_1=sqlite3_column_int(stmt, 2);
            NSString *docent_name=[NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 3)];
            NSString *s_date=[NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 4)];
            NSString *n_date=[NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 5)];
            NSString *pic=[NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 6)];
            int status=sqlite3_column_int(stmt, 7);
            NSString *obj_id=[NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 8)];
            NSString *introduce=[NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 9)];
            // 赋值
            course.id=ID;
            course.name=name;
            course.c_type_1=c_type_1;
            course.docent_name=docent_name;
            course.s_date=s_date;
            course.n_date=n_date;
            course.pic=pic;
            course.status=status;
            course.obj_id=obj_id;
            course.introduce=introduce;
        }
        sqlite3_finalize(stmt);
        return course;
    }else{
        NSLog(@"查询失败:%d",result);
    }
    //释放
    sqlite3_finalize(stmt);
    return nil;
}

@end
