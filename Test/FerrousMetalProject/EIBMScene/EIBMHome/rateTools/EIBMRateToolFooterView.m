//
//  RateToolFooterView.m
//  BlackIronProject
//
//  Created by mac on 2019/8/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "EIBMRateToolFooterView.h"
#import "UIResponder+responder.h"
@implementation EIBMRateToolFooterView
- (IBAction)goRateDown:(id)sender {
    [self endEditing:YES];
    [self responderWithName:@"rateGo" userInfo:nil];
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    _Btn.backgroundColor = MainColor;
    _Btn.layer.masksToBounds = YES;
    _Btn.layer.cornerRadius = 5;
    self.backgroundColor = kWhiteColor;
    self.titleLabel.textColor = TitleColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
