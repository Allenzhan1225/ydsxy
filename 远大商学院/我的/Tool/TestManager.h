//
//  TestManager.h
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/4.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UpdateUI) (NSMutableArray *array,int d_id);

@interface TestManager : NSObject

/**
 *  网络请求
 *
 *  @param url  网址
 *  @param type 0 正常；1 搜索
 */
- (void)requestDataWithURL:(NSString *)url withType:(int)type;

@property (nonatomic,copy) UpdateUI manager;

@end
