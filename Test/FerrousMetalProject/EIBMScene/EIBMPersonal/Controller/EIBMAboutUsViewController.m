//
//  AboutUsViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 05/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMAboutUsViewController.h"
#import "EIBMSettingTableViewCell.h"
#import "EIBMServerHtmlViewController.h"
@interface EIBMAboutUsViewController ()
@property(nonatomic, copy)NSArray *titleArray;
@end

@implementation EIBMAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"关于我们"];
    [self setLeftButtonStyle:AAButtonStyleBack];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-57)/2, 40, 57, 57)];
    iconImageView.layer.cornerRadius = 2;
    iconImageView.layer.masksToBounds = YES;
    iconImageView.image = [UIImage imageNamed:@"appIogal"];
    [self.contentView addSubview:iconImageView];
    //AA出行
    UILabel *nameLabel = [EIBMFactoryTool labelWithFont:[UIFont systemFontOfSize:16.0] textAlignment:NSTextAlignmentCenter textColor:TitleColor];
    nameLabel.frame = CGRectMake(0, CGRectGetMaxY(iconImageView.frame)+6, SCREEN_WIDTH, 26);
    nameLabel.text = @"黄金期货王";
    [self.contentView addSubview:nameLabel];
    //版本号
    UILabel *versionLabel  = [EIBMFactoryTool labelWithFont:[UIFont systemFontOfSize:14.0] textAlignment:NSTextAlignmentCenter textColor:[UIColor lightGrayColor]];
    versionLabel.frame = CGRectMake(0, CGRectGetMaxY(nameLabel.frame), SCREEN_WIDTH, 20);
    versionLabel.text = APP_VERSION;
    [self.contentView addSubview:versionLabel];
    
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(versionLabel.mas_bottom).offset(25);
    }];
    self.myTableView.backgroundColor = LLBackGroundWhiteColor;
    _titleArray = [NSArray arrayWithObjects:@"隐私条款", nil];
    [self.myTableView registerNib:[UINib nibWithNibName:@"SettingTableViewCell" bundle:nil] forCellReuseIdentifier:@"SettingTableViewCell"];
}

- (NSDate *)dateAfterDay:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:[NSDate new] options:0];
    
    return dateAfterDay;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EIBMSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingTableViewCell" forIndexPath:indexPath];
    [cell setDataWithTitle:[_titleArray objectAtIndex:indexPath.row] detail:@">"];
    cell.bottomLine.hidden = NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EIBMServerHtmlViewController *html = [EIBMServerHtmlViewController new];
    html.title = @"隐私条款";
    [self.navigationController pushViewController:html animated:YES];
}

@end
