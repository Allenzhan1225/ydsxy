//
//  RequestLoginData.h
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/11.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
// 用户详情数据请求

#import <Foundation/Foundation.h>
#import "LoginModel.h"

typedef void (^UpdataUI) (LoginModel *model,NSString *str);

@interface RequestLoginData : NSObject

- (void)requestDataWithURL:(NSString *)url;

@property (nonatomic,copy) UpdataUI manager;

@end
