//
//  RateToolVC.m
//  BlackIronProject
//
//  Created by mac on 2019/8/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "EIBMRateToolVC.h"
#import "EIBMrateView.h"
@interface EIBMRateToolVC ()
@property (nonatomic ,strong)EIBMrateView *rateView;
@end

@implementation EIBMRateToolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"期货换算工具"];
    [self setLeftButtonStyle:AAButtonStyleBack];
    self.view.backgroundColor = kWhiteColor;
    [self.view addSubview:self.rateView];
    [self.rateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}
-(EIBMrateView *)rateView
{
    if (!_rateView) {
        _rateView = [[EIBMrateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - Nav_topH)];
        _rateView.vc = self;
    }
    return _rateView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
