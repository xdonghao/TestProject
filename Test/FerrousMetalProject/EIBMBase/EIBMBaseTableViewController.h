//
//  BaseTableViewController.h
//  carrental
//
//  Created by liu on 16/6/18.
//  Copyright © 2016年 maple. All rights reserved.
//

#import "EIBMBaseViewController.h"

@interface EIBMBaseTableViewController : EIBMBaseViewController

@property (nonatomic,strong) UITableView     *myTableView;
- (void)eibm_AddNoDataView;
- (void)setupRefresh;
- (void)headerEndRefresh;
- (void)footerEndRefresh;
@end

@interface EIBMBaseTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@end
