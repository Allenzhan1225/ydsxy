//
//  CompanyMessageModel.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/18.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "CompanyMessageModel.h"

@implementation CompanyMessageModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"--%@--%@--%@--%@--",_title,_content,_u_name,_add_date];
}

@end
