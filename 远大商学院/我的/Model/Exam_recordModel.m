//
//  Exam_recordModel.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/3.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "Exam_recordModel.h"

@implementation Exam_recordModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%d-%@-%@",_id,_t_p_name,_read_over_lecturer];
}

@end
