//
//  SetViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 31/07/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMSetViewController.h"
#import "EIBMSettingTableViewCell.h"
#import "EIBMAboutUsViewController.h"
#import "EIBMForumManager.h"

@interface EIBMSetViewController ()

@property(nonatomic, copy)NSArray *titleArray;

@end

@implementation EIBMSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"设置"];
    [self setLeftButtonStyle:AAButtonStyleBack];
    self.myTableView.backgroundColor = LLBackGroundWhiteColor;
    [self.myTableView registerNib:[UINib nibWithNibName:@"SettingTableViewCell" bundle:nil] forCellReuseIdentifier:@"SettingTableViewCell"];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EIBMSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingTableViewCell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        [cell setDataWithTitle:@"关于我们" detail:@">"];
    } else if (indexPath.row == 1) {
        [cell setDataWithTitle:@"清除缓存" detail:@""];
    } else if (indexPath.row == 2) {
        [cell setDataWithTitle:@"版本信息" detail:@"1.0"];
    }
    
    cell.bottomLine.hidden = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([EIBMUserUtil sharedUserUtil].user) {
        return 68.5;
    }
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ([EIBMUserUtil sharedUserUtil].user) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 68.5)];
        view.backgroundColor = [UIColor clearColor];
        UIButton *btn = [EIBMFactoryTool buttonWithType:UIButtonTypeCustom Target:self action:@selector(btnADClick) forControlEvents:UIControlEventTouchUpInside font:[UIFont systemFontOfSize:17.0] textColor:[UIColor whiteColor]];
        btn.frame = CGRectMake(15, 68.5-44, SCREEN_WIDTH-30, 44);
        [btn setTitle:@"退出登录" forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 3.0;
        [btn setBackgroundColor:MainColor];
        [view addSubview:btn];
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[EIBMAboutUsViewController new] animated:YES];
    } else if (indexPath.row == 1) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"清理缓存" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [NSObject showHUDQueryStr:@"清理中..."];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [NSObject hideHUDQuery];
            });
            [[[SDWebImageManager sharedManager] imageCache] clearWithCacheType:SDImageCacheTypeDisk completion:^{
            }];
            
        }];
        UIAlertAction *cancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:cancle];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
}


- (void)btnADClick {
    WEAKSELF
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定要退出登录么？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [[EIBMUserUtil sharedUserUtil] clearCache];
        [weakSelf.myTableView reloadData];
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (NSDate *)aabbcc:(NSInteger)minute {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMinute:minute];
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    
    return dateAfterDay;
}

@end
