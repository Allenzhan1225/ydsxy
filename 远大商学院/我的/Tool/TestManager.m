//
//  TestManager.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/4.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "TestManager.h"
#import "TestModel.h"

@implementation TestManager

- (void)requestDataWithURL:(NSString *)url withType:(int)type{
    AFHTTPSessionManager *sessionManager=[AFHTTPSessionManager manager];
    NSSet *set = [NSSet setWithObject:@"text/html"];
    [sessionManager.responseSerializer setAcceptableContentTypes:set];

    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // modelArray
        NSMutableArray *array=[NSMutableArray array];
        // keysArray of sorting
        NSDictionary *dic=responseObject[@"data"][@"t_paper_list"];
        NSMutableArray *keyArray=[NSMutableArray arrayWithArray:dic.allKeys];
        [keyArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 localizedStandardCompare:obj2];
        }];
        
        for (int i=0; i<keyArray.count; i++) {
            if (![keyArray[i] isEqualToString:@"time"]) {
                TestModel *model=[TestModel new];
                [model setValuesForKeysWithDictionary:dic[keyArray[i]]];
                [array addObject:model];
            }
        }
        if (type==0) {
            int d_id=[responseObject[@"data"][@"d_id"] intValue];
            self.manager(array,d_id);
        }else if (type==1){
            self.manager(array,0);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error==%@",error);
    }];
}

@end
