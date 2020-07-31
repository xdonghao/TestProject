//
//  NewsFlashViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 04/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMNewsFlashViewController.h"
#import "EIBMNewsFlashModel.h"
#import "EIBMNewsFlashTableViewCell.h"
#import "EIBMNewsFlashHeaderView.h"
#import "YMOpenAnimation.h"
@interface EIBMNewsFlashViewController ()
@property (nonatomic, strong) YMOpenAnimation *animation;
@end

@implementation EIBMNewsFlashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"公告"];
    self.myTableView.backgroundColor = kWhiteColor;
    [self setLeftButtonStyle:AAButtonStyleBack];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    [self.myTableView registerClass:[EIBMNewsFlashHeaderView class] forHeaderFooterViewReuseIdentifier:@"NewsFlashHeaderView"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"NewsFlashTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsFlashTableViewCell"];
    [self loadData];
}

- (void)loadData {
    [self.dataArr removeAllObjects];
    NSData *dataStock = [NSData dataWithContentsOfFile:self.listDataJsonPath];
    NSArray *stockJson = [NSJSONSerialization JSONObjectWithData:dataStock options:0 error:nil];
    for (NSDictionary *modelDic in stockJson) {
        EIBMNewsFlashModel *model = [EIBMNewsFlashModel mj_objectWithKeyValues:modelDic];
        if (self.show) {
            model.isExpanded = YES;
        }
        [self.dataArr addObject:model];
        
    }
    [self.myTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    EIBMNewsFlashModel *model = [self.dataArr objectAtIndex:section];
    return model.isExpanded ? 1 : 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    EIBMNewsFlashHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"NewsFlashHeaderView"];
    EIBMNewsFlashModel *model = [self.dataArr objectAtIndex:section];
    headerView.title = model.title;
    headerView.model = model;
    headerView.expandCallback = ^(BOOL isExpanded) {
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section]
                 withRowAnimation:UITableViewRowAnimationFade];
    };
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EIBMNewsFlashTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsFlashTableViewCell" forIndexPath:indexPath];
    EIBMNewsFlashModel *model = [self.dataArr objectAtIndex:indexPath.section];
    cell.titleLabel.text = [NSString stringWithFormat:@"    %@",model.content];
    cell.timeLabel.text = model.time;
    cell.bottomLine.hidden = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    EIBMNewsFlashModel *model = [self.dataArr objectAtIndex:indexPath.section];
    return [EIBMNewsFlashTableViewCell getCellHeightWithString:model.content];
}

+(NSString *)moneyWithString:(NSString *)moneyStr{
    NSString * str = nil;
    if (moneyStr&&moneyStr.length>0) {
        float money = [moneyStr floatValue];
        if (money == 0) {
            str = @"0";
            return  str;
        }else{
            str = [NSString stringWithFormat:@"%.2f",money];
            NSArray* arr=[str componentsSeparatedByString:@"."];
            if (arr.count==2&&[[arr lastObject] intValue]==0) {
                str=[[str componentsSeparatedByString:@"."] firstObject];
                return str;
            }
            if ([(NSString*)[arr lastObject] length]>1) {
                
                NSString* lastChar=[[arr lastObject] substringFromIndex:1];
                
                if (arr.count==2&&[lastChar isEqualToString:@"0"]) {
                    str=[NSString stringWithFormat:@"%@.%@",[arr objectAtIndex:0],[[arr lastObject] substringWithRange:NSMakeRange(0, 1)]];
                }
            }
        }
    }
    return str;
}



- (void)viewDidDisappear:(BOOL)animated{
    self.navigationController.delegate = nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        self.animation.isPop = NO;
    } else if (operation == UINavigationControllerOperationPop) {
        self.animation.isPop = YES;
    }
    return self.animation;
}


- (YMOpenAnimation *)animation {
    if (nil == _animation) {
        _animation = [[YMOpenAnimation alloc] init];
    }
    return _animation;
}
@end
