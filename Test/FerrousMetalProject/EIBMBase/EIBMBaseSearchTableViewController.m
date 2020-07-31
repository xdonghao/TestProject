//
//  ACSMBaseSearchTableViewController.m
//  FarmExpert
//
//  Created by 董浩 on 2017/11/15.
//  Copyright © 2017年 xstone. All rights reserved.
//

#import "EIBMBaseSearchTableViewController.h"

@interface EIBMBaseSearchTableViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UIButton *xButton;
@end

@implementation EIBMBaseSearchTableViewController

- (UIButton *)xButton
{
    if (!_xButton) {
        _xButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_xButton setImage:[UIImage imageNamed:@"dl_button_gb_body"] forState:UIControlStateNormal];
        [_xButton setImage:[UIImage imageNamed:@"dl_button_dxgb_body"] forState:UIControlStateHighlighted];
        _xButton.hidden = YES;
        [_xButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _xButton;
}
-(void)btnClick:(UIButton *)btn{
    self.searchBar.text = @"";
    [self.view endEditing:YES];
    self.xButton.hidden = YES;
    [self clearSearchText];
}

- (NSDate *)someone:(NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:[NSDate new] options:0];
    
    return dateAfterMonth;
}

-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.placeholder = @"";
        _searchBar.delegate = self;
        _searchBar.tintColor = [UIColor lightGrayColor];
//        for (UIView* subview in [[_searchBar.subviews lastObject] subviews]) {
//            if ([subview isKindOfClass:[UITextField class]]) {
//                UITextField *textField = (UITextField*)subview;
//                textField.clearButtonMode = UITextFieldViewModeNever;
//                //                textField.textColor = [UIColor redColor];                         //修改输入字体的颜色
//                [textField setBackgroundColor:[UIColor whiteColor]];      //修改输入框的颜色
//                //                [textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];   //修改placeholder的颜色
//            } else if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
//            {
//                _searchBar.backgroundColor = LLBackGroundWhiteColor;
//                //                subview.backgroundColor = LIGHTGRAYBACKGROUNDCOLOR;
//                [subview removeFromSuperview];
//            }
//        }
        
    }
    return _searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.contentView addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.height.mas_equalTo(50);
    }];
    
    [self.searchBar addSubview:self.xButton];
    [self.xButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.searchBar.mas_right).offset(-3);
        make.centerY.equalTo(self.searchBar.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchBar.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

- (void)searchString:(NSString *)searchText{
    
}

- (void)clearSearchText{
    
}

#pragma mark - SearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    //    [searchBar resignFirstResponder];
    //    [_tableView.header beginRefreshing];
//    [self searchString:searchBar.text];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    //    [_tableView.header beginRefreshing];
    [self searchString:searchBar.text];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    self.xButton.hidden = NO;
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    self.xButton.hidden = YES;
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
