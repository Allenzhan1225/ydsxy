//
//  RequestMessageOfCompany.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/18.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "RequestMessageOfCompany.h"
#import "CompanyMessageModel.h"

@interface RequestMessageOfCompany()

@end

@implementation RequestMessageOfCompany

- (void)requestDataWithURL:(NSString *)url{
    AFHTTPSessionManager *sessionManager=[AFHTTPSessionManager manager];
    NSSet *set = [NSSet setWithObject:@"text/html"];
    [sessionManager.responseSerializer setAcceptableContentTypes:set];

    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        NSLog(@"downloadProgress==%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success!");
        NSMutableArray *array=[NSMutableArray array];
        NSDictionary *dic=responseObject[@"data"];
        NSMutableArray *keyArray=[NSMutableArray arrayWithArray:dic.allKeys];
        [keyArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 localizedStandardCompare:obj2];
        }];
        for (int i=0; i<keyArray.count; i++) {
                CompanyMessageModel *model=[CompanyMessageModel new];
                [model setValuesForKeysWithDictionary:dic[keyArray[i]]];
                [array addObject:model];
        }
        self.manager(array);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error==%@",error);
    }];
}

@end
