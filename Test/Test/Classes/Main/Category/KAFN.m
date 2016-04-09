//
//  KAFN.m
//  AFN
//
//  Created by wk on 15/12/17.
//  Copyright © 2015年 wk. All rights reserved.
//

#import "KAFN.h"
#import <AFNetworking.h>

@implementation KAFN

+ (NSString *)kCaptureUrl:(NSString *)url
{
    if ([url rangeOfString:@"?"].location != NSNotFound)
    {
        NSRange range = [url rangeOfString:@"?"];
        url = [url substringToIndex:range.location];
    }
    return url;
}

+ (NSMutableDictionary *)kDealParamsOfUrl:(NSString *)url params:(NSMutableDictionary *)params
{
    if ([url rangeOfString:@"?"].location != NSNotFound)
    {
        NSRange range = [url rangeOfString:@"?"];
        NSString *parameterString = [url substringFromIndex:range.location + 1];
        if ([parameterString rangeOfString:@"&"].location != NSNotFound)
        {
            NSArray *paramsArr = [parameterString componentsSeparatedByString:@"&"];
            for (int i = 0; i < paramsArr.count; i ++)
            {
                NSString *temporaryString = paramsArr[i];
                NSArray *temporaryArr = [temporaryString componentsSeparatedByString:@"="];
                NSString *keyStr = temporaryArr[0];
                NSString *valueStr = temporaryArr[1];
                params[keyStr] = valueStr;
//                NSLog(@"参数：%@=%@", keyStr, valueStr);
            }
            
        }
        else
        {
            NSArray *temporaryArr = [parameterString componentsSeparatedByString:@"="];
            NSString *keyStr = temporaryArr[0];
            NSString *valueStr = temporaryArr[1];
            params[keyStr] = valueStr;
//            NSLog(@"参数：%@=%@", keyStr, valueStr);
        }
    }
    
    return params;
}


+ (void)kGet:(NSString *)URLString parameters:(id)parameters success:(void(^)(NSDictionary * dict))success failure:(void(^)())failue;
{
    AFHTTPSessionManager *manager = [self createManager];
    
    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        success(dict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    
//    [manager GET:requestURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
//        
//        success(dict);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        failue();
//    }];
}

+ (void)kPost:(NSString *)url :(NSDictionary *)dict success:(void(^)(NSDictionary * dict))success failure:(void(^)())failue
{
//    AFHTTPRequestOperationManager * manager = [self createManager];
//    
//    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation * operation, id responseObject) {
//        
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
//        
//        success(dict);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        failue();
//    }];
}





- (NSString *)createQuaryString:(NSDictionary *)dict
{
    NSMutableString * result = [NSMutableString stringWithCapacity:0];
    
    for(NSString * value in [dict allValues])
    {
        [result appendFormat:@"%@/",value];
    }
    
    return [result substringToIndex:result.length - 1];
}

+ (AFHTTPSessionManager *)createManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 请求时间
    manager.requestSerializer.timeoutInterval = 20.0;
    // 是否允许CA不信任的证书通过
    manager.securityPolicy.allowInvalidCertificates = YES;
    // 是否验证主机名
    manager.securityPolicy.validatesDomainName = NO;
    // 接受数据格式
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    // 服务器返回数据解析方式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    return manager;
}




@end
