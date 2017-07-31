//
//  C_two_lsitModel.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/21.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "C_two_lsitModel.h"

@implementation C_two_lsitModel

// 容错处理
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

// print details
-(NSString *)description{
    return [NSString stringWithFormat:@"%@--%@--%@--%@--%@--",_name,_title,_pic,_add_name,_date];
    
}

@end
