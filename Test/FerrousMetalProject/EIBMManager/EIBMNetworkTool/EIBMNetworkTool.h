//
//  NetworkTool.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 31/07/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EIBMError.h"

typedef NS_ENUM(NSUInteger, HTTPRequestMethod) {
    HTTPRequestMethodGet,
    HTTPRequestMethodPost,
    HTTPRequestMethodPut,
    HTTPRequestMethodPatch,
    HTTPRequestMethodDelete,
};


NS_ASSUME_NONNULL_BEGIN

@interface EIBMNetworkTool : NSObject

+ (instancetype)sharedNetworkTool;

/**
 *  request
 *
 *  @param method        method(SDHTTPRequestMethod)
 *  @param urlString     urlString
 *  @param parameters    parameters
 *  @param completeBlock completeBlock
 */
- (void)toolRequestWithHTTPMethod:(HTTPRequestMethod)method
                        URLString:(NSString *)urlString
                       parameters:(NSDictionary *)parameters
                         complete:(void (^)(id responseObject, EIBMError *error))completeBlock;

/**
 *  request cancel
 */
-(void)cancelRequest;

//- (void)OSSWithFileName:(NSString *)fileName
//             folderName:(NSString *)folderName
//            andFileData:(NSData *)fileData
//         uploadProgress:(void (^)(CGFloat progress))progressBlock
//               complete:(void (^)(NSString *url,EIBMError *error))completeBlock;

@end

NS_ASSUME_NONNULL_END
