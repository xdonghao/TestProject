//
//  PublishForumViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 06/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMPublishForumViewController.h"
#import "EIBMForumManager.h"
#import "EIBMForumReplyManager.h"

@interface EIBMPublishForumViewController ()
/**
 *  textView
 */
@property (nonatomic, strong) UITextView *textView;
@end

@implementation EIBMPublishForumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *name = self.isPublish ? @"发表" : @"回复";
    [self setNavigationBarTitle:name];
    [self setLeftButtonStyle:AAButtonStyleBack];
    
    UILabel *label = [EIBMFactoryTool labelWithFont:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:TitleColor];
    label.text = @"请在此输入您要发表的动态";
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(20);
        make.top.equalTo(self.contentView.mas_top).offset(10);
    }];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectZero];
    _textView.placeholder = @"请输入内容";
    _textView.maxInputLength = 400;
    _textView.textColor = TitleColor;
    _textView.backgroundColor = kWhiteColor;
    _textView.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(200);
        make.top.equalTo(label.mas_bottom).offset(10);
    }];
    
    UIButton *btn = [EIBMFactoryTool buttonWithType:UIButtonTypeCustom Target:self action:@selector(eibm_BtnClick) forControlEvents:UIControlEventTouchUpInside font:[UIFont systemFontOfSize:17.0] textColor:[UIColor whiteColor]];
    [btn setTitle:name forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 3.0;
    [btn setBackgroundColor:MainColor];
    [self.contentView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_textView.mas_bottom).offset(20);
        make.centerX.equalTo(self->_textView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-30, 44));
    }];
}

- (void)eibm_BtnClick {
    if (_textView.text.length == 0) {
        [NSObject showHudTipStr:@"请输入文字"];
        return;
    }
    
    if (self.isPublish) {
        EIBMForumListModel *model = [[EIBMForumListModel alloc] init];
        model.content = _textView.text;
        model.userName = [EIBMUserUtil sharedUserUtil].user.userName;
        model.created = [NSNumber numberWithLong:[[NSDate date] utcTimeStamp]];
        model.userImageUrl = @"";
        [[EIBMForumManager shared] addDBDataWithForumListObjects:@[model]];
        if (self.success) {
            self.success(model);
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        EIBMForumListModel *model = [[EIBMForumListModel alloc] init];
        model.content = _textView.text;
        model.userName = [EIBMUserUtil sharedUserUtil].user.userName;
        model.created = [NSNumber numberWithLong:[[NSDate date] utcTimeStamp]];
        model.userImageUrl = @"";
        model.articleId = self.articleId;
        [[EIBMForumReplyManager shared] addDBDataWithForumReplyObjects:@[model]];
        if (self.success) {
            self.success(model);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

@end
