//
//  RecentClassDetailManager.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/11.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "RecentClassDetailManager.h"
#import "CoursesModel.h"

@implementation RecentClassDetailManager

- (void)requestDataWithURL:(NSString *)url clickIsOrNo:(BOOL)isOrNo{
    AFHTTPSessionManager *sessionManager=[AFHTTPSessionManager manager];
    NSSet *set = [NSSet setWithObject:@"text/html"];
    [sessionManager.responseSerializer setAcceptableContentTypes:set];

    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //        NSLog(@"downloadProgress==%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success!");
        if (isOrNo==NO) {
            // modelArray
            NSMutableArray *array=[NSMutableArray array];
            // keysArray of sorting
            NSDictionary *dic=responseObject[@"data"];
            NSMutableArray *keyArray=[NSMutableArray arrayWithArray:dic.allKeys];
            [keyArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                return [obj1 localizedStandardCompare:obj2];
            }];
            NSString *string=dic[@"time"];
            for (int i=0; i<keyArray.count; i++) {
                if (![keyArray[i] isEqualToString:@"time"]) {
                    CoursesModel *model=[CoursesModel new];
                    [model setValuesForKeysWithDictionary:dic[keyArray[i]]];
                    [array addObject:model];
                }
            }
            self.manager(array,string);
        }else if (isOrNo==YES){
            NSString *string=responseObject[@"message"];
            self.enroll(string);
        }
//        NSLog(@"%@",array);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error==%@",error);
    }];
}

@end
