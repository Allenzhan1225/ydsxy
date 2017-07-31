//
//  Exam_recordManager.h
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/3.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UpdataUI)(NSMutableArray *array);

@interface Exam_recordManager : NSObject

@property (nonatomic,copy) UpdataUI manager;

- (void)requestDataWithURL:(NSString *)url;

@end
