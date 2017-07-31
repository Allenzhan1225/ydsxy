//
//  ResourcesModel.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/20.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "ResourcesModel.h"

@implementation ResourcesModel

// 容错处理
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

// print details
-(NSString *)description{
    return [NSString stringWithFormat:@"%@--%@--%@--%@--_num=%d--_click=%d",_name,_level,_pic,_add_date,_num,_click];
    
}

@end
