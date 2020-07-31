//
//  PersonCenterViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 30/07/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMPersonCenterViewController.h"
#import "EIBMPersonCenterHeadCollectionViewCell.h"
#import "EIBMButtonCollectionViewCell.h"
#import "EIBMPersonnalCollectionViewCell.h"
#import "EIBMLoginDetailController.h"
#import "EIBMQuestionViewController.h"
#import "EIBMSetViewController.h"
#import "EIBMPersonalInfoDetailViewController.h"
#import "EIBMMyCollectCenterViewController.h"
#import "EIBMMyShieldViewController.h"
#import <StoreKit/StoreKit.h>
#import "EIBMMyCollectViewController.h"
#import "EIBMWebHtmlViewController.h"
#import "EIBMHeaderLineCollectionReusableView.h"
#import "EIBMNewsFlashViewController.h"
@interface EIBMPersonCenterViewController ()

@property (nonatomic ,copy) NSArray *titleArray;
@property (nonatomic ,copy) NSArray *imageArray;
@end

@implementation EIBMPersonCenterViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.myCollectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self setLeftButtonStyle:AAButtonStyleDismiss];
    [self setNavigationBarBackgroundColor:[UIColor clearColor]];
    self.navigationBarView.titleLabel.backgroundColor = [UIColor clearColor];
    self.navigationBarView.titleLabel.textColor = [UIColor whiteColor];
    [self setRightButtonStyle:AAButtonStyleNotice];
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"PersonCenterHeadCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PersonCenterHeadCollectionViewCell"];
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"PersonnalCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PersonnalCollectionViewCell"];
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"ButtonCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ButtonCollectionViewCell"];
    [self.myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [self.myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    [self.myCollectionView registerClass:[EIBMHeaderLineCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderLineCollectionReusableView"];
    _titleArray = [NSArray arrayWithObjects:@"我的主页", @"我的收藏",@"黑名单", @"意见反馈", @"在线客服", @"设置", nil];
    _imageArray = [NSArray arrayWithObjects:@"eibm_person_message",@"eibm_person_collect",@"eibm_person_shield", @"eibm_person_que",@"eibm_person_pf",@"eibm_person_set", nil];
    CGFloat y = IS_IPHONE_X ? 44 : 20;
    [self.myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(-y);
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    self.myCollectionView.hidden = YES;
    
    
}

#pragma mark - CollectionDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return _titleArray.count;
    }else
        return 1;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (![EIBMUserUtil sharedUserUtil].user) {
        WEAKSELF
        EIBMLoginDetailController *login = [EIBMLoginDetailController new];
        EIBMBaseNavigationViewController *loginNav =[[EIBMBaseNavigationViewController alloc]initWithRootViewController:login];
        [login setSuccessBlock:^{
            [weakSelf.myCollectionView reloadData];
        }];
        [self presentViewController:loginNav animated:YES completion:^{
            [self.myCollectionView reloadData];
        }];
        return;
    }
    if (indexPath.section == 0) {
        
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            EIBMPersonalInfoDetailViewController *info = [[EIBMPersonalInfoDetailViewController alloc] init];
            [self.navigationController pushViewController:info animated:YES];
        } else if (indexPath.row == 1) {
//            MyCollectCenterViewController *center = [[MyCollectCenterViewController alloc] initPersonCenter];
//            [self.navigationController pushViewController:center animated:YES];
            EIBMMyCollectViewController *center= [[EIBMMyCollectViewController alloc] init];
            [self.navigationController pushViewController:center animated:YES];
        } else if (indexPath.row == 2) {
            [self.navigationController pushViewController:[EIBMMyShieldViewController new] animated:YES];
        } else if(indexPath.row == 3) {
            [self.navigationController pushViewController:[EIBMQuestionViewController new] animated:YES];
        } else if(indexPath.row == 4) {
//            if (@available(iOS 10.3, *)) {
//                [SKStoreReviewController requestReview];
//            }
            EIBMWebHtmlViewController *web = [[EIBMWebHtmlViewController alloc] init];
            web.urlStr = @"https://www.sobot.com/chat/h5/index.html?sysNum=9ec98afea51647059292fa126a0e4c01&source=2&tel=&uname=%E6%B8%B8%E5%AE%A2&face=null&remark=null";
            web.titleStr = @"在线客服";
            [self.navigationController pushViewController:web animated:YES];
        } else if(indexPath.row == 5) {
             [self.navigationController pushViewController:[EIBMSetViewController new] animated:YES];
        }  else {
           
        }
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定要退出登录么？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            [[EIBMUserUtil sharedUserUtil] clearCache];
            [self.myCollectionView reloadData];
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 8);
    }
    if (section == 1) {
        return CGSizeMake(SCREEN_WIDTH, 0.01);
    }
    return CGSizeMake(SCREEN_WIDTH, 0.01);
}

//这个方法是返回 Header的大小 size
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return CGSizeMake(SCREEN_WIDTH, 0.01);
//    }
//    if (section == 1) {
//        return CGSizeMake(SCREEN_WIDTH, 50);
//    }
//    return CGSizeMake(SCREEN_WIDTH, 0.01);
//}

//这个也是最重要的方法 获取Header的 方法。
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        EIBMHeaderLineCollectionReusableView *cell = (EIBMHeaderLineCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderLineCollectionReusableView" forIndexPath:indexPath];
        cell.bottomLine.hidden = YES;
        cell.leftLabel.hidden = YES;
        cell.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        if(indexPath.section == 1){
            cell.titleLabel.text = @"业务管理";
            cell.leftLabel.hidden = NO;
            cell.moreLabel.hidden = YES;
            cell.arrowImageView.hidden = YES;
        }else{
            cell.moreLabel.hidden = YES;
            cell.arrowImageView.hidden = YES;
            cell.titleLabel.text = @"";
        }
        return cell;
    }else{
        UICollectionReusableView *footerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        
        footerView.backgroundColor = LLBackGroundWhiteColor;
        return footerView;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        EIBMPersonCenterHeadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PersonCenterHeadCollectionViewCell" forIndexPath:indexPath];
        [cell setDataWithSourceData:nil];
        return cell;
    } else if(indexPath.section == 1) {
        EIBMPersonnalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PersonnalCollectionViewCell" forIndexPath:indexPath];
        [cell setDataWithTitle:[_titleArray objectAtIndex:indexPath.row] imageName:[_imageArray objectAtIndex:indexPath.row]];
        cell.bottomLine.hidden = NO;
        return cell;
    }else{
        EIBMButtonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ButtonCollectionViewCell" forIndexPath:indexPath];
        cell.titleLabel.text = @"退出登录";
        return cell;
    }
}


//设置每个 UICollectionView 的大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 300);
    }else{
        
        return CGSizeMake(SCREEN_WIDTH, 45);
    }
}

//定义每个UICollectionView 的间距

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0,0);
}


//定义每个UICollectionView 的纵向间距
//横间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.01;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.01;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)leftButtonClick {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)rightButtonClick {
//    [self AAPresentViewController:[EIBMPersonCenterViewController new] animated:YES];
    EIBMNewsFlashViewController *new = [[EIBMNewsFlashViewController alloc] init];
    new.listDataJsonPath = [[NSBundle mainBundle] pathForResource:@"dashijian_k_data" ofType:@"json"];
    new.show = YES;
    new.title = @"公告";
    [self.navigationController pushViewController:new animated:YES];
}

@end
