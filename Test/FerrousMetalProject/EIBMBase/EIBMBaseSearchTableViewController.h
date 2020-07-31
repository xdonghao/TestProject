//
//  ACSMBaseSearchTableViewController.h
//  FarmExpert
//
//  Created by 董浩 on 2017/11/15.
//  Copyright © 2017年 xstone. All rights reserved.
//

#import "EIBMBaseTableViewController.h"

@interface EIBMBaseSearchTableViewController : EIBMBaseTableViewController
@property (nonatomic, strong)UISearchBar *searchBar;
- (void)searchString:(NSString *)searchText;

- (void)clearSearchText;
@end
