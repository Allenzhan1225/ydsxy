//
//  RequestLastestNewsData.m
//  BusinessSchoolOfYDWY
//
//  Created by YDWY on 16/6/13.
//  Copyright © 2016年 YDWY. All rights reserved.
//

#import "RequestLastestNewsData.h"

#import "CompanyMessageModel.h"
#import "BusinessSchoolNewsModel.h"

@implementation RequestLastestNewsData

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
            BusinessSchoolNewsModel *model=[BusinessSchoolNewsModel new];
            [model setValuesForKeysWithDictionary:dic[keyArray[i]]];
            [array addObject:model];
        }
        self.managerUI(array);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error==%@",error);
    }];
}

@end
