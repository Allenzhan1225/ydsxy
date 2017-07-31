//
//  BusinessSchoolNewsModel.m
//  BusinessSchoolOfYDWY
//
//  Created by YDWY on 16/7/15.
//  Copyright © 2016年 YDWY. All rights reserved.
//

#import "BusinessSchoolNewsModel.h"

@implementation BusinessSchoolNewsModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"filename=%@--title=%@--litpic=%@--",_filename,_title,_litpic];
}

@end
