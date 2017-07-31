//
//  CheckMealModel.m
//  远大商学院
//
//  Created by YDWY on 16/8/30.
//  Copyright © 2016年 YDWY. All rights reserved.
//

#import "CheckMealModel.h"

@implementation CheckMealModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"description"]) {
        _Description=key;
    }
}

-(NSString *)description{
    return [NSString stringWithFormat:@"title=%@--senddate=%ld--Description=%@",_title,(long)_senddate,_Description];
}

@end
