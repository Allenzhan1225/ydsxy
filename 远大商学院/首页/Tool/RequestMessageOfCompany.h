//
//  RequestMessageOfCompany.h
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/18.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
// 公司信息获取

#import <Foundation/Foundation.h>

typedef void (^UpdataUI) (NSMutableArray *array);

@interface RequestMessageOfCompany : NSObject

@property (nonatomic,copy) UpdataUI manager;

- (void)requestDataWithURL:(NSString *)url;

@end
