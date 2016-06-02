    //
//  AFHTTPUtil.m
//  G4Manager
//
//  Created by yangxiaodong on 15/11/2.
//  Copyright © 2015年 cmol. All rights reserved.
//


#import "AFHTTPSupport.h"

#define HTTP_JSON @"application/json"
#define HTTP_TEXT @"text/html"
#define HTTP_PLAIN @"text/plain"


@interface AFHTTPSupport ()

@end

@implementation AFHTTPSupport

+ (instancetype)shareAFHTTP
{
    static AFHTTPSupport *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        instance = [[AFHTTPSupport alloc] init];
    });
    return instance;
}



- (void)getHeaderHttpRequest3:(NSString*)urlStr
                        param:(NSDictionary*)param
                         time:(NSInteger)time
               baseController:(UIViewController*)vc
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:time];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:HTTP_TEXT, HTTP_JSON,HTTP_PLAIN,  nil];
    
    [manager GET:urlStr parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}





@end
 
