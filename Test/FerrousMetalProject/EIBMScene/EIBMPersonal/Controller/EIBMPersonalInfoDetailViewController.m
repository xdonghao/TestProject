//
//  PersonalInfoDetailViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 05/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMPersonalInfoDetailViewController.h"
#import "EIBMPersonalInfoCustomTableViewCell.h"
#import "EIBMPersonalInfoDetailHeadTableViewCell.h"
#import "EIBMActionSheetView.h"
#import <AVFoundation/AVFoundation.h>
#import "EIBMDatePickerView.h"
#import "EIBMPersonalInfoRemarkTableViewCell.h"
@interface EIBMPersonalInfoDetailViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate,EIBMDatePickerViewDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) NSData *headerImageData;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *remark;

@end

@implementation EIBMPersonalInfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"我的主页"];
    [self setLeftButtonStyle:AAButtonStyleBack];
    [self.navigationBarView.rightButton setTitle:@"保存" forState:UIControlStateNormal];
    self.headerImageData = [EIBMUserUtil sharedUserUtil].user.headerImageData;
    self.sex = [EIBMUserUtil sharedUserUtil].user.sex;
    self.birthday = [EIBMUserUtil sharedUserUtil].user.birthday;
    self.remark = [EIBMUserUtil sharedUserUtil].user.remark;
    self.myTableView.backgroundColor = LLBackGroundWhiteColor;
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.myTableView registerClass:[EIBMPersonalInfoCustomTableViewCell class] forCellReuseIdentifier:@"PersonalInfoCustomTableViewCell"];
    [self.myTableView registerClass:[EIBMPersonalInfoRemarkTableViewCell class] forCellReuseIdentifier:@"PersonalInfoRemarkTableViewCell"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0||section == 2) {
        return 1;
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 75.0;
    } else if (indexPath.section == 1){
        return 50;
    }else {
        return [EIBMPersonalInfoRemarkTableViewCell getCellHeightWithString:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        EIBMPersonalInfoDetailHeadTableViewCell *cell = [EIBMPersonalInfoDetailHeadTableViewCell cellWithTableView:tableView];
        if (self.headerImageData) {
            [cell.iconImageView setImage:[UIImage imageWithData:self.headerImageData]];
        } else {
            [cell.iconImageView setImage:[UIImage imageNamed:@"eibm_person_touxiang"]];
        }
        return cell;
    } else if (indexPath.section == 1){
        EIBMPersonalInfoCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalInfoCustomTableViewCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            [cell.iconImageView setImage:[UIImage imageNamed:@"eibm_personInfo_sex"]];
            cell.infoLabel.text = self.sex.length>0 ? self.sex : @"请选择";
        }
        if (indexPath.row == 1) {
            [cell.iconImageView setImage:[UIImage imageNamed:@"eibm_personInfo_birthday"]];
            cell.infoLabel.text = self.birthday.length>0 ? self.birthday : @"请选择出生年月日";
        }
        cell.bottomLine.hidden = NO;
        return cell;
    } else {
        EIBMPersonalInfoRemarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalInfoRemarkTableViewCell" forIndexPath:indexPath];
        cell.text.text = self.remark;
        WEAKSELF
        [cell setSuccessBlock:^(NSString * _Nonnull remark) {
            weakSelf.remark = remark;
        }];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WEAKSELF
    if (indexPath.section == 0) {
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
    } else  if (indexPath.section == 1){
        if (indexPath.row == 0) {
            NSArray *titlearr = @[@"男",@"女",@"保密"];
            EIBMActionSheetView *actionsheet = [[EIBMActionSheetView alloc] initWithShareHeadOprationWith:titlearr andImageArry:@[] andProTitle:@"" and:ShowTypeIsActionSheetStyle];
            [actionsheet setBtnClick:^(NSInteger btnTag) {
                if (btnTag == 0) {
                    self.sex = @"男";
                } else if (btnTag == 1){
                    self.sex = @"女";
                } else {
                    self.sex = @"保密";
                }
                [weakSelf.myTableView reloadData];
            }];
            [[UIApplication sharedApplication].keyWindow addSubview:actionsheet];
        } else if (indexPath.row == 1) {
            EIBMDatePickerView *dateAAPicker = [[EIBMDatePickerView alloc] initWithCancleTitle:@"取消" andSureTitle:@"确定"];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY-MM-dd"];
            NSDate *date;
            if (self.birthday != nil && self.birthday.length > 0) {
                date = [dateFormatter dateFromString:self.birthday];
            } else {
                date = [dateFormatter dateFromString:@"1980-01-01"];
            }
            dateAAPicker.datePicker.date = date;
            dateAAPicker.delegate = self;
            [dateAAPicker showInView:self.navigationController.view];
        }
    }
}

- (void)rightButtonClick {
    EIBMUser *user = [EIBMUserUtil sharedUserUtil].user;
    user.headerImageData = self.headerImageData;
    user.sex = self.sex;
    user.birthday = self.birthday;
    user.remark = self.remark;
    [[EIBMUserUtil sharedUserUtil] saveCache:user];
    [user update];
    [NSObject showHudTipStr:@"保存成功"];
    [self.navigationController popViewControllerAnimated:YES];
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
    picker.allowsEditing = YES;
    picker.navigationBar.translucent = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePickerController = picker;
    [self presentViewController:picker animated:YES completion:nil];
    
}

#pragma mark - image picker delegte

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.headerImageData  = UIImagePNGRepresentation(image);
    [self.myTableView reloadData];
//    NSString *timeStr = [NSDate datestrFromDate:[NSDate date] withDateFormat:@"yyyyMMdd"];
//    [[EIBMNetworkTool sharedNetworkTool] OSSWithFileName:timeStr folderName:@"farming" andFileData:self.headerImageData uploadProgress:^(CGFloat progress) {
//        
//    } complete:^(NSString * _Nonnull url, EIBMError * _Nonnull error) {
//        
//    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma AADatePickerViewDelegate

- (void)sureClickWithString:(NSString *)dateStr{
    if (dateStr != nil) {
        self.birthday = dateStr;
        [self.myTableView reloadData];
    }
}
@end
