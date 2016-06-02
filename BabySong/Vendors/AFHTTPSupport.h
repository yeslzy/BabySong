//
//  AFHTTPUtil.h
//  G4Manager
//
//  Created by yangxiaodong on 15/11/2.
//  Copyright © 2015年 cmol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface AFHTTPSupport : NSObject

+ (instancetype)shareAFHTTP;


- (void)getHeaderHttpRequest3:(NSString*)urlStr
                         param:(NSDictionary*)param
                          time:(NSInteger)time
                baseController:(UIViewController*)vc
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
