//
//  QuestionnaireModel.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/28.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "QuestionnaireModel.h"

@implementation QuestionnaireModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%d,%@,%d,%d,%@,%@",_id,_name,_department,_status,_add_u_name,_add_date];
}

@end
