//
//  TestModel.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/4.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%d--%d--%d--%@",_id,_d_id,_exam_time,_name];
}

@end
