//
//  CoursesModel.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/21.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "CoursesModel.h"

@implementation CoursesModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"id=%d---name=%@--obj_i=%@--_docent_name=%@--pic=%@----",_id,_name,_obj_id,_docent_name,self.pic];
}

-(instancetype)initWithID:(int)id withName:(NSString *)name withIntroduce:(NSString *)introduce withC_type_1:(int)c_type_1 withDocent_name:(NSString *)docent_name withS_date:(NSString *)s_date withN_date:(NSString *)n_date withPic:(NSString *)pic withStatus:(int)status withObj_id:(NSString *)obj_id{
    if (self=[super init]) {
        _name=name;
        _id=id;
        _c_type_1=c_type_1;
        _docent_name=docent_name;
        _s_date=s_date;
        _pic=pic;
        _status=status;
        _obj_id=obj_id;
        _n_date=n_date;
        _introduce=introduce;
    }
    return self;
    
}

@end
