//
//  ACSMBaseSearchCollectionViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 08/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseSearchCollectionViewController.h"

@interface EIBMBaseSearchCollectionViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UIButton *xButton;

@end

@implementation EIBMBaseSearchCollectionViewController

- (UIButton *)xButton
{
    if (!_xButton) {
        _xButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_xButton setImage:[UIImage imageNamed:@"dl_button_gb_body"] forState:UIControlStateNormal];
        [_xButton setImage:[UIImage imageNamed:@"dl_button_dxgb_body"] forState:UIControlStateHighlighted];
        _xButton.hidden = YES;
        //        [_xButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
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
    
    [self.myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
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

@end
