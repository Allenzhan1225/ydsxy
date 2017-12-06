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
    if([key isEqualToString:@"title"]){
        if(![value isKindOfClass:[NSString class]]){
            self.title = [NSString stringWithFormat:@"%@",value];
        }else{
           self.title = [NSString stringWithFormat:@"%@",value]; 
        }
    }
}

// print details
-(NSString *)description{
    return [NSString stringWithFormat:@"%@--%@--%@--%@--",_name,_pic,_add_name,_date];
}



-(void)setModleWithDict:(NSDictionary *)dict{
    if(dict){
        if (dict[@"id"]) {
            self.id = [dict[@"id"] intValue];
        }
        if (dict[@"name"]) {
            self.name = dict[@"name"] ;
        }
        
        if (dict[@"title"]) {
            self.title = [NSString stringWithFormat:@"%@",dict[@"title"]];
        }
        
        if (dict[@"pic"]) {
            self.pic = dict[@"pic"];
        }
        
        if (dict[@"add_name"]) {
            self.add_name = dict[@"add_name"];
        }
        
        if (dict[@"date"]) {
            self.date = dict[@"date"];
        }
        
        if (dict[@"num"]) {
            self.num = [dict[@"num"] integerValue];
        }
    }
}

@end
