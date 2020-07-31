//
//  QHWToolsModel.m
//  QHW_FuturesPro
//
//  Created by MAC on 2019/8/20.
//  Copyright © 2019 LZT. All rights reserved.
//

#import "EIBMXMWGToolsModel.h"

@implementation EIBMXMWGToolsModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleArr = @[@"大豆",@"玉米",@"LME",@"天然橡胶",@"小麦",@"PTA"];
        self.imgArr = @[@"dadou",@"yumi",@"LME",@"tianranxiangjiao",@"xiaomai",@"PTA"];
        self.styleArray = @[@[@"CBOT大豆价格",@"海湾基差",@"海运费用",@"汇率"],@[@"CBOT盘面价格",@"基差美分",@"汇率",@"关税税率(%)",@"增值税税率(%)",@"港杂费(元)"],@[@"LME三月铜",@"伦敦现货三个月升贴水",@"上海铜与LME铜升贴水",@"汇率",@"关税税率(%)",@"增殖税率(%)",@"其他费用(元)"],@[@"泰国FOB价格(美元/吨)",@"贸易升水(美元/吨)",@"海上运费(美元/吨)",@"保险费(美元/吨)",@"汇率",@"关税(%)",@"增值税(%)",@"运杂费(元)"],@[@"国内CIF到岸价",@"汇率",@"关税税率(%)",@"增值税税率(%)",@"港杂费(元)"],@[@"PTA外盘价",@"汇率"]];
    }
    return self;
}

//大豆
+ (NSString *)soybeanONE:(NSString *)one TWO:(NSString *)two THREE:(NSString *)three FOUR:(NSString *)four{
    
    float importedPic = (one.floatValue + two.floatValue + three.floatValue) * 0.367433 * four.floatValue * 1.03 * 1.13 + 120.00;
    NSString * overString = [[NSString alloc]initWithFormat:@"%.2f",importedPic];
    return overString;
}

//玉米
+ (NSString *)CornONE:(NSString *)one TWO:(NSString *)two THREE:(NSString *)three FOUR:(NSString *)four FIVE:(NSString *)five SIX:(NSString *)six{
    float importedPic = (one.floatValue + two.floatValue) * 0.367437 * three.floatValue * (1 + four.floatValue/100) * (1 + five.floatValue/100) + six.floatValue;
    NSString * overString = [[NSString alloc]initWithFormat:@"%.2f",importedPic];
    return overString;
}
//LME
+ (NSString *)LMECotisonONE:(NSString *)one TWO:(NSString *)two THREE:(NSString *)three FOUR:(NSString *)four FIVE:(NSString *)five SIX:(NSString *)six SEVEN:(NSString *)seven{
    float importedPic = (one.floatValue + two.floatValue + three.floatValue) * four.floatValue * (1 + five.floatValue/100) * (1 + six.floatValue/100) + seven.floatValue;
    NSString * overString = [[NSString alloc]initWithFormat:@"%.2f",importedPic];
    return overString;
}
//天然橡胶
+ (NSString *)NaturalRubberONE:(NSString *)one TWO:(NSString *)two THREE:(NSString *)three FOUR:(NSString *)four FIVE:(NSString *)five SIX:(NSString *)six SEVEN:(NSString *)seven EIGHT:(NSString *)eight{
    
    float importedPic = (one.floatValue + two.floatValue + three.floatValue + four.floatValue) * five.floatValue * (1 + six.floatValue/100) * (1 + seven.floatValue/100) + eight.floatValue;
    NSString * overString = [[NSString alloc]initWithFormat:@"%.2f",importedPic];
    return overString;
    
    
}
//小麦
+ (NSString *)WheatONE:(NSString *)one TWO:(NSString *)two THREE:(NSString *)three FOUR:(NSString *)four FIVE:(NSString *)five{
    float importedPic = one.floatValue * two.floatValue * (1 + three.floatValue) * ( 1 + four.floatValue) + five.floatValue;
    NSString * overString = [[NSString alloc]initWithFormat:@"%.2f",importedPic];
    return overString;
}
//PTA
+ (NSString *)PTACotisonONE:(NSString *)one TWO:(NSString *)two{
    float importedPic = one.floatValue * 1.17 * 1.06 * two.floatValue;
    NSString * overString = [[NSString alloc]initWithFormat:@"%.2f",importedPic];
    return overString;
}


@end
