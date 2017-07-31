//
//  LoginModel.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/11.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%ld--%@--%@--%ld",(long)_id,_login_name,_login_password,(long)_is_send_message];
}

@end
