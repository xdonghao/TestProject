//
//  QHWToolsModel.h
//  QHW_FuturesPro
//
//  Created by MAC on 2019/8/20.
//  Copyright © 2019 LZT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EIBMXMWGToolsModel : NSObject
@property (nonatomic,strong)NSArray *titleArr;
@property (nonatomic,strong)NSArray *imgArr;
@property (nonatomic,strong)NSArray *styleArray;
//大豆
+ (NSString *)soybeanONE:(NSString *)one TWO:(NSString *)two THREE:(NSString *)three FOUR:(NSString *)four;

//玉米
+ (NSString *)CornONE:(NSString *)one TWO:(NSString *)two THREE:(NSString *)three FOUR:(NSString *)four FIVE:(NSString *)five SIX:(NSString *)six;
//LME
+ (NSString *)LMECotisonONE:(NSString *)one TWO:(NSString *)two THREE:(NSString *)three FOUR:(NSString *)four FIVE:(NSString *)five SIX:(NSString *)six SEVEN:(NSString *)seven;
//天然橡胶
+ (NSString *)NaturalRubberONE:(NSString *)one TWO:(NSString *)two THREE:(NSString *)three FOUR:(NSString *)four FIVE:(NSString *)five SIX:(NSString *)six SEVEN:(NSString *)seven EIGHT:(NSString *)eight;
//小麦
+ (NSString *)WheatONE:(NSString *)one TWO:(NSString *)two THREE:(NSString *)three FOUR:(NSString *)four FIVE:(NSString *)five;
//PTA
+ (NSString *)PTACotisonONE:(NSString *)one TWO:(NSString *)two;
@end

NS_ASSUME_NONNULL_END
