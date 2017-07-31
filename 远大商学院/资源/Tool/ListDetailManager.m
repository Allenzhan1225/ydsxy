
//
//  ListDetailManager.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/7.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "ListDetailManager.h"
#import "C_two_lsitModel.h"

@implementation ListDetailManager
- (void)requestDataWithURL:(NSString *)url{
    AFHTTPSessionManager *sessionManager=[AFHTTPSessionManager manager];
    NSSet *set = [NSSet setWithObject:@"text/html"];
    [sessionManager.responseSerializer setAcceptableContentTypes:set];

    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //        NSLog(@"downloadProgress==%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Test-success!");
        // modelArray
        NSMutableArray *array=[NSMutableArray array];
        // keysArray of sorting
        NSDictionary *dic=responseObject[@"data"][@"c_two_data"];
        NSMutableArray *keyArray=[NSMutableArray arrayWithArray:dic.allKeys];
        [keyArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 localizedStandardCompare:obj2];
        }];
        for (int i=0; i<keyArray.count; i++) {
            C_two_lsitModel *model=[C_two_lsitModel new];
            [model setValuesForKeysWithDictionary:dic[keyArray[i]]];
            [array addObject:model];
        }
        self.manager(array);
        //        NSLog(@"%@",array);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error==%@",error);
    }];
}
@end
