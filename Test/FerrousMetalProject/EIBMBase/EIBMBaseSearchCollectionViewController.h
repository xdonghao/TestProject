//
//  ACSMBaseSearchCollectionViewController.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 08/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseCollectionViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMBaseSearchCollectionViewController : EIBMBaseCollectionViewController
@property (nonatomic, strong)UISearchBar *searchBar;
- (void)searchString:(NSString *)searchText;

- (void)clearSearchText;
@end

NS_ASSUME_NONNULL_END
