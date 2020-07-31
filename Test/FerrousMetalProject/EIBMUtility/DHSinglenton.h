//
//  DHSinglenton.h
//  FarmRecovery
//
//  Created by 董浩 on 2016/10/20.
//  Copyright © 2016年 donghao. All rights reserved.
//

#ifndef DHSinglenton_h
#define DHSinglenton_h

#import <objc/runtime.h>

#pragma mark - @interface

#undef	DH_SYNTHESIZE_SINGLETON_INTERFACE
#define DH_SYNTHESIZE_SINGLETON_INTERFACE( __class ) \
\
+ (__class *)sharedInstance; \
\
+ (void)load; \
\

#pragma mark - @implementation

#undef	DH_SYNTHESIZE_SINGLETON_IMPLEMENTION
#define DH_SYNTHESIZE_SINGLETON_IMPLEMENTION( __class ) \
\
static __class * __singleton__; \
\
+ (__class *)sharedInstance \
{ \
static dispatch_once_t predicate; \
dispatch_once( &predicate, ^{ __singleton__ = [[[self class] alloc] init]; } ); \
return __singleton__; \
} \
+ (void)load \
{ \
[self sharedInstance]; \
} \

#endif /* DHSinglenton_h */
