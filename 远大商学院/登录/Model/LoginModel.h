//
//  LoginModel.h
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/11.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
// 用户登录信息

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject

/**
 *  用户登录信息
 *  用户id、用户名、用户密码
 */
@property (nonatomic,assign) NSInteger id;
@property (nonatomic,strong) NSString *login_name;
@property (nonatomic,strong) NSString *login_password;
@property (nonatomic,assign) int is_send_message;   // 1 || 0   1为讲师或管理员

@end
