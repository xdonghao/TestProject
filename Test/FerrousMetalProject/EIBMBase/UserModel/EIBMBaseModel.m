//
//  BaseModel.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 30/07/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseModel.h"
#import "MJExtension.h"
@implementation EIBMBaseModel
MJCodingImplementation

#pragma mark KVC 安全设置
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%s",__func__);
}
- (void)setNilValueForKey:(NSString *)key
{
    NSLog(@"%s",__func__);
}

- (NSString *)description
{
    unsigned int count;
    NSMutableDictionary *propertyDict = [NSMutableDictionary dictionary];
    Ivar *ivar = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar iv = ivar[i];
        const char *name = ivar_getName(iv);
        NSString *strName = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:strName];
        if (!value) {
            value = [NSNull null];
        }
        [propertyDict setObject:value forKey:strName];
    }
    free(ivar);
    return propertyDict.description;
}
@end
