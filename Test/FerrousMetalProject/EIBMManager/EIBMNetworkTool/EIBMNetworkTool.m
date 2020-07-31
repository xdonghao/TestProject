//
//  NetworkTool.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 31/07/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMNetworkTool.h"
#import "AFNetworking.h"
NSString * const XHeaderContentType    = @"Content-Type";
NSString * const EndPoint                             = @"http://img4.farmeasy.cn";
NSString * const PicBucketName                        = @"acsm-test";
NSString * const AccessKeyId                          = @"vnDsZNCnznL9aQYj";
NSString * const AccessKeySecret                      = @"CjccwyfS7yJRPDid1QuHyRiOtq5oae";
@interface EIBMNetworkTool()

@property (nonatomic, strong) AFHTTPSessionManager *httpSessionManager;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
//@property (nonatomic, strong) OSSClient * ossClient;

@end

@implementation EIBMNetworkTool

+ (instancetype)sharedNetworkTool
{
    static EIBMNetworkTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[EIBMNetworkTool alloc] init];
//        [tool initOSSClient];
    });
    
    return tool;
}

/**
 初始化OSS
 */
//- (void)initOSSClient {
//    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKeyId secretKey:AccessKeySecret];
//
//    OSSClientConfiguration * conf = [OSSClientConfiguration new];
//    conf.maxRetryCount = 2;
//    conf.timeoutIntervalForRequest = 30;
//    conf.timeoutIntervalForResource = 24 * 60 * 60;
//    self.ossClient = [[OSSClient alloc] initWithEndpoint:EndPoint credentialProvider:credential clientConfiguration:conf];
//}

//- (void)OSSWithFileName:(NSString *)fileName
//             folderName:(NSString *)folderName
//            andFileData:(NSData *)fileData
//         uploadProgress:(void (^)(CGFloat progress))progressBlock
//               complete:(void (^)(NSString *url,EIBMError *error))completeBlock{
//
//    NSString *UUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//    NSInteger timestamp = [NSDate cTimestampFromDate:[NSDate date]];
//    NSString *timeStr = [NSDate datestrFromDate:[NSDate date] withDateFormat:@"yyyyMMdd"];
//
////    NSString *companyId = [ACSMUserInfoManagement getCompanyId];
////    if ([ACSMCommonMeansTool isEmpty:companyId]) {
////        companyId = @"1";
////    }
//    NSString *companyId = @"1";
//    NSString *ssss = [NSString stringWithFormat:@"00000000%@",companyId];
//    companyId = [ssss substringFromIndex:ssss.length-8];
//
//    NSString *nameString = [NSString stringWithFormat:@"%@/%@/%@/%ld%@/%@",companyId,folderName,timeStr,timestamp,[UUID substringToIndex:5],fileName];
//
//    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
//
//    // required fields
//    put.bucketName = PicBucketName;
//    put.objectKey = nameString;
//    put.uploadingData = fileData;
//
//    // optional fields
//    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
//        float progress = (float)totalByteSent/totalBytesExpectedToSend;
//        progressBlock(progress);
//
////        DLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
//    };
//    //    put.contentType = @"";
//    //    put.contentMd5 = @"";
//    //    put.contentEncoding = @"";
//    //    put.contentDisposition = @"";
//
//    OSSTask * putTask = [self.ossClient putObject:put];
//
//    [putTask continueWithBlock:^id(OSSTask *task) {
////        DLog(@"objectKey: %@", put.objectKey);
//        if (!task.error) {
//
//            NSString *url = [NSString stringWithFormat:@"%@/%@",EndPoint,put.objectKey];
//
//            completeBlock(url,nil);
//        } else {
//            EIBMError *error = [EIBMError acsm];
//            error.resMsg = task.error.localizedDescription;
//            completeBlock(nil,error);
//        }
//        return nil;
//    }];
//}


- (void)startNetwork
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)endNetwork
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)toolRequestWithHTTPMethod:(HTTPRequestMethod)method
                        URLString:(NSString *)urlString
                       parameters:(NSDictionary *)parameters
                         complete:(void (^)(id responseObject, EIBMError *error))completeBlock{
    
    [self startNetwork];
    
    AFHTTPSessionManager *httpSessionManager = self.httpSessionManager;
    
    httpSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [httpSessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //    if ([ACSMUserUtil sharedUserUtil].user.token) {
    //        [httpSessionManager.requestSerializer setValue:[ACSMUserUtil sharedUserUtil].user.token forHTTPHeaderField:@"auth_token"];
    //    }
    
    WEAKSELF
    switch (method) {
        case HTTPRequestMethodGet:{
            [httpSessionManager GET:urlString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                [weakSelf endNetwork];
                completeBlock(responseObject, nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [weakSelf endNetwork];
                EIBMError *errorModel = [EIBMError new];
                errorModel.resMsg = @"无法连接，请检查您的网络";
                completeBlock(nil, errorModel);
//                [NSObject showHudTipStr:@"无法连接，请检查您的网络"];
            }];
            break;
        }
        case HTTPRequestMethodPost: {
            [httpSessionManager POST:urlString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                [weakSelf endNetwork];
                completeBlock(responseObject, nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [weakSelf endNetwork];
                EIBMError *errorModel = [EIBMError new];
                errorModel.resMsg = @"无法连接，请检查您的网络";
                errorModel.resCode = 404;
                completeBlock(nil, errorModel);
//                [NSObject showHudTipStr:@"无法连接，请检查您的网络"];
            }];
            
            break;
        }
        case HTTPRequestMethodPut: {
            [httpSessionManager PUT:urlString
                         parameters:parameters
                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                [weakSelf endNetwork];
                                completeBlock(responseObject, nil);
                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                [weakSelf endNetwork];
                                EIBMError *errorModel = [EIBMError new];
                                errorModel.resMsg = @"无法连接，请检查您的网络";
                                completeBlock(nil, errorModel);
                                [NSObject showHudTipStr:@"无法连接，请检查您的网络"];
                            }];
            break;
        }
        case HTTPRequestMethodPatch: {
            [httpSessionManager PATCH:urlString
                           parameters:parameters
                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                  [weakSelf endNetwork];
                                  completeBlock(responseObject, nil);
                              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                  [weakSelf endNetwork];
                                  EIBMError *errorModel = [EIBMError new];
                                  errorModel.resMsg = @"无法连接，请检查您的网络";
                                  completeBlock(nil, errorModel);
                                  [NSObject showHudTipStr:@"无法连接，请检查您的网络"];
                              }];
            break;
        }
        case HTTPRequestMethodDelete: {
            [httpSessionManager DELETE:urlString
                            parameters:parameters
                               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                   [weakSelf endNetwork];
                                   completeBlock(responseObject, nil);
                               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                   [weakSelf endNetwork];
                                   EIBMError *errorModel = [EIBMError new];
                                   errorModel.resMsg = @"无法连接，请检查您的网络";
                                   completeBlock(nil, errorModel);
                                   [NSObject showHudTipStr:@"无法连接，请检查您的网络"];
                               }];
            break;
        }
    }
}


- (void)cancelRequest
{
    [self endNetwork];
    // 取消之前请求
    [self.httpSessionManager.tasks makeObjectsPerformSelector:@selector(cancel)];
}

- (AFHTTPSessionManager *)httpSessionManager
{
    if (_httpSessionManager == nil) {
        
        _httpSessionManager = [AFHTTPSessionManager manager];
    }
    _httpSessionManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    _httpSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"application/xml",@"text/xml",@"text/json",@"text/plain",@"text/javascript",@"text/html", nil];
    [_httpSessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:XHeaderContentType];
    return _httpSessionManager;
}


- (NSString *)getToken
{
    NSString *token = @"bm9uY2VzdHI9N0Q4RjNDM0NFNUU2NjIxRUJDMTM5Q0VDMkM1REUyQTYmc2lnbmF0dXJlPTEzN0ZGNDVCNzk5NjVCMDI2NTAwQUE0N0UyREE5Q0FEJnRpbWVzdGFtcD0xNTA0ODM2OTgxNjI1";
    return token;
}

@end
