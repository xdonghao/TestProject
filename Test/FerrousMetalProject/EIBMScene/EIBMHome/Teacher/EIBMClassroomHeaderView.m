//
//  ClassroomHeaderView.m
//  BlackWhiteFuProject
//
//  Created by MAC on 02/09/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMClassroomHeaderView.h"

@implementation EIBMClassroomHeaderView

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [EIBMFactoryTool labelWithFont:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentCenter textColor:TitleColor];
    }
    return _timeLabel;
}

@end
