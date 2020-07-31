//
//  TalkSendViewController.m
//  EIBMGoodsProject
//
//  Created by MAC on 20/09/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "TalkSendViewController.h"
#import "EIBMActionSheetView.h"
#import <AVFoundation/AVFoundation.h>
#import "EIBMTalkListManager.h"
#import "EIBMCustomButton.h"

@interface TalkSendViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong)UILabel *titleField;
@property (nonatomic, strong)UITextView *contentTextView;
@property (nonatomic, strong)UIButton *picButton;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong)UIImage *articleImg;
@property (nonatomic, copy) NSString *type;
@end

@implementation TalkSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"发布话题"];
    [self setLeftButtonStyle:AAButtonStyleBack];
    self.type = @"0";
    [self configUI];
    
}

-(void)configUI{
    
    UIView *whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = kWhiteColor;
    [self.contentView addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(SCREEN_HEIGHT/2);
    }];
    
    NSArray *title = @[@"原油",@"美铜",@"黄金",@"英镑"];
    for (NSInteger i = 0; i<4; i++) {
        CGFloat x = i*(SCREEN_WIDTH-20)/4;
        UIButton *button = [[EIBMCustomButton alloc] initWithFrame:CGRectMake(x, 10, (SCREEN_WIDTH-20)/4, 60)];
        NSString *name = [NSString stringWithFormat:@"talk_item_%ld",i];
        [button setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        [button setTitle:title[i] forState:UIControlStateNormal];
        [button setTitleColor:kBlackColor forState:UIControlStateNormal];
        
        
        button.tag = 1000 + i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:button];
        if (i == 0) {
//            button.selected = YES;
            [button setTitleColor:MainColor forState:UIControlStateNormal];
        }
    }
    
    
    _titleField = [[UILabel alloc] init];
    _titleField.text = @"请输入话题标题";
    _titleField.font = [UIFont systemFontOfSize:18];
    [whiteView addSubview:_titleField];
    [_titleField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteView.mas_left).offset(10);
        make.right.equalTo(whiteView.mas_right).offset(-10);
        make.top.equalTo(whiteView.mas_top).offset(80);
        make.height.mas_equalTo(40);
    }];
    UILabel *lable = [[UILabel alloc] init];
    lable.backgroundColor = [UIColor lightGrayColor];
    lable.alpha = 0.3;
    [whiteView addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteView.mas_left).offset(10);
        make.right.equalTo(whiteView.mas_right).offset(-10);
        make.top.equalTo(self->_titleField.mas_bottom).offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    _contentTextView = [[UITextView alloc] init];
    _contentTextView.font = [UIFont systemFontOfSize:16];
    _contentTextView.backgroundColor = kWhiteColor;
    _contentTextView.placeholder = @"在此输入...";
    [whiteView addSubview:_contentTextView];
    [_contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteView.mas_left).offset(10);
        make.right.equalTo(whiteView.mas_right).offset(-10);
        make.top.equalTo(lable.mas_bottom).offset(0);
        make.height.mas_equalTo(75);
    }];
    
    
    _picButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_picButton setImage:[UIImage imageNamed:@"group_write_article_iv_bg"] forState:UIControlStateNormal];
    [_picButton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:_picButton];
    [_picButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.bottom.equalTo(whiteView.mas_bottom).offset(-10);
    }];
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"添加图片";
    label2.textColor = [UIColor lightGrayColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:14];
    [whiteView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_picButton.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(80, 20));
        make.centerY.equalTo(self->_picButton.mas_centerY);
    }];
    
    UILabel *bottomLine = [[UILabel alloc] init];
    bottomLine.backgroundColor = [UIColor lightGrayColor];
    bottomLine.alpha = 0.3;
    [whiteView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteView.mas_left).offset(0);
        make.right.equalTo(whiteView.mas_right).offset(0);
        make.bottom.equalTo(whiteView.mas_bottom).offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    
    UIButton *btn = [EIBMFactoryTool buttonWithType:UIButtonTypeCustom Target:self action:@selector(sendArticleClick) forControlEvents:UIControlEventTouchUpInside font:[UIFont systemFontOfSize:17.0] textColor:[UIColor whiteColor]];
    [btn setTitle:@"发布" forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 3.0;
    [btn setBackgroundColor:MainColor];
    [self.contentView addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(44);
    }];
}

- (void)buttonClick:(UIButton *)button {
    for (NSInteger i = 0; i<4; i++) {
        UIButton *btn = [self.contentView viewWithTag:(1000 +i)];
        if (btn.tag == button.tag) {
            [btn setTitleColor:MainColor forState:UIControlStateNormal];
            self.type = [NSString stringWithFormat:@"%ld",i];
        } else {
            [btn setTitleColor:kBlackColor forState:UIControlStateNormal];
        }
    }
}

-(void)sendArticleClick{
    if (self.contentTextView.text.length == 0) {
        [NSObject showHudTipStr:@"标题不能为空"];
        return;
    }
    if (self.contentTextView.text.length > 45) {
        [NSObject showHudTipStr:@"标题最多可输入45个字"];
        return;
    }
    if (!self.articleImg) {
        [NSObject showHudTipStr:@"图片不能为空"];
        return;
    }
//    WEAKSELF
    NSData *imageData = UIImageJPEGRepresentation(self.articleImg, 1);
//    NSString *timeStr = [NSDate datestrFromDate:[NSDate date] withDateFormat:@"yyyyMMdd"];
    NSString *title = self.contentTextView.text;
    NSString *type = self.type;
    
    
    
    TalkListModel *model = [[TalkListModel alloc] init];
    model.imageUrl = @"";
    model.title = title;
    model.type = type;
    model.created = [NSDate datestrFromDate:[NSDate date] withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    model.imageData = imageData;
    [[EIBMTalkListManager shared] addDBDataWithTalkListObjects:@[model]];
    if (self.success) {
        self.success(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
//    [NSObject showHUDQueryStr:@"提交中..." inView:self.navigationController.view];
//    [[EIBMNetworkTool sharedNetworkTool] OSSWithFileName:timeStr folderName:@"farming" andFileData:imageData uploadProgress:^(CGFloat progress) {
//
//    } complete:^(NSString * _Nonnull url, EIBMError * _Nonnull error) {
//        [NSObject hideHUDQueryInView:self.navigationController.view];
//        if (error) {
//            [NSObject showHudTipStr:@"提交失败，请重试"];
//        }else {
//            TalkListModel *model = [[TalkListModel alloc] init];
//            model.imageUrl = url;
//            model.title = title;
//            model.type = type;
//            model.created = [NSDate datestrFromDate:[NSDate date] withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//            [[TalkListManager shared] addDBDataWithTalkListObjects:@[model]];
//            if (weakSelf.success) {
//                weakSelf.success(model);
//            }
//            [weakSelf.navigationController popViewControllerAnimated:YES];
//        }
//    }];
}

- (void)btnClick {
    WEAKSELF
    NSArray *titlearr = @[@"拍照",@"选择照片"];
    EIBMActionSheetView *actionsheet = [[EIBMActionSheetView alloc] initWithShareHeadOprationWith:titlearr andImageArry:@[] andProTitle:@"" and:ShowTypeIsActionSheetStyle];
    [actionsheet setBtnClick:^(NSInteger btnTag) {
        if (btnTag == 0) {
            [weakSelf enterCamera];
        }else{
            [weakSelf enterAlbum];
        }
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:actionsheet];
}

#pragma mark ******* 进入相机 *******
- (void)enterCamera{
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if((status == AVAuthorizationStatusAuthorized)||(status == AVAuthorizationStatusNotDetermined)){//允许和第一次打开
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.navigationBar.translucent = NO;
        picker.sourceType = sourceType;
        _imagePickerController = picker;
        [self presentViewController:picker animated:YES completion:nil];
    }else if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted){//不允许
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请在iPhone的“设置－隐私－相机”选项中，允许App访问您的相机。" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark ******* 进入相册 *******
- (void)enterAlbum{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.navigationBar.translucent = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePickerController = picker;
    [self presentViewController:picker animated:YES completion:nil];
    
}

#pragma mark - image picker delegte

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.articleImg  = image;
    [_picButton setImage:self.articleImg forState:UIControlStateNormal];

    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
