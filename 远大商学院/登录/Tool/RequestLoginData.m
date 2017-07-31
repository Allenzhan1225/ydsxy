//
//  RequestLoginData.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/11.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "RequestLoginData.h"

@interface RequestLoginData ()

//@property (nonatomic,strong) NSDictionary *dic;

@end

@implementation RequestLoginData

- (void)requestDataWithURL:(NSString *)url{
    AFHTTPSessionManager *sessionManager=[AFHTTPSessionManager manager];
     NSSet *set = [NSSet setWithObject:@"text/html"];
    [sessionManager.responseSerializer setAcceptableContentTypes:set];
    
    
//    sessionManager.
    
    
    NSDictionary *dictionary=[NSDictionary dictionary];
    [sessionManager GET:url parameters:dictionary progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict=responseObject[@"data"];
        NSString *string=responseObject[@"message"];
        LoginModel *model=[LoginModel new];
        [model setValuesForKeysWithDictionary:dict];
//        NSLog(@"success!--%@--%@",dict,model);
        self.manager(model,string); // 加一个error回调，正常则为nil，失败则为error。
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"******error******=%@",error);
    }];
}

@end
