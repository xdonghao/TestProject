//
//  RateToolDetailVC.m
//  BlackIronProject
//
//  Created by mac on 2019/8/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "EIBMRateToolDetailVC.h"
#import "EIBMRateToolTFCell.h"
#import "EIBMRateToolFooterView.h"
#import "EIBMXMWGToolsModel.h"

@interface EIBMRateToolDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView        *tableView;
@property (nonatomic, strong) EIBMRateToolFooterView *footerView;
@property (nonatomic ,strong) EIBMXMWGToolsModel *toolsModel;


@end

@implementation EIBMRateToolDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:[NSString stringWithFormat:@"%@进口成本计算",self.titlestr]];
    [self setLeftButtonStyle:AAButtonStyleBack];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"RateToolTFCell" bundle:nil] forCellReuseIdentifier:@"RateToolTFCell"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}
-(void)setTitlestr:(NSString *)titlestr
{
    _titlestr = titlestr;
}
-(EIBMXMWGToolsModel *)toolsModel
{
    if (!_toolsModel) {
        _toolsModel = [[EIBMXMWGToolsModel alloc] init];
    }
    return _toolsModel;
}
-(void)setStyleArr:(NSArray *)styleArr
{
    _styleArr = styleArr;
}
-(void)responderWithName:(NSString *)name userInfo:(NSDictionary *)info
{

    if ([name isEqualToString:@"rateGo"]) {
        
        NSInteger rows = [self.tableView numberOfRowsInSection:0];
        NSMutableArray *StrArr = [NSMutableArray array];;
        for (int row = 0; row < rows; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
                  EIBMRateToolTFCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
            if (cell.TextField.text.length) {
                [StrArr addObject:cell.TextField.text];
            }
            else
            {
                [NSObject showHudTipStr:@"请输入完整数据"];
                return;
            }
        }
        
        NSString *footerStr;
        if ([_titlestr isEqualToString:@"大豆"]) {
            
          footerStr =  [EIBMXMWGToolsModel soybeanONE:StrArr[0] TWO:StrArr[1] THREE:StrArr[2] FOUR:StrArr[3]];
        }
        else if ([_titlestr isEqualToString:@"玉米"])
        {
            footerStr =   [EIBMXMWGToolsModel CornONE:StrArr[0] TWO:StrArr[1] THREE:StrArr[2] FOUR:StrArr[3] FIVE:StrArr[4] SIX:StrArr[5]];
        }
        else if ([_titlestr isEqualToString:@"LME"])
        {
            footerStr =   [EIBMXMWGToolsModel LMECotisonONE:StrArr[0] TWO:StrArr[1] THREE:StrArr[2] FOUR:StrArr[3] FIVE:StrArr[4] SIX:StrArr[5] SEVEN:StrArr[6]];
        } else if ([_titlestr isEqualToString:@"天然橡胶"])
        {
                     footerStr =   [EIBMXMWGToolsModel LMECotisonONE:StrArr[0] TWO:StrArr[1] THREE:StrArr[2] FOUR:StrArr[3] FIVE:StrArr[4] SIX:StrArr[5] SEVEN:StrArr[6]];
            
        } else if ([_titlestr isEqualToString:@"小麦"])
        {
                      footerStr =   [EIBMXMWGToolsModel WheatONE:StrArr[0] TWO:StrArr[1] THREE:StrArr[2] FOUR:StrArr[3] FIVE:StrArr[4]];
            
        } else if ([_titlestr isEqualToString:@"PTA"])
        {
        footerStr =   [EIBMXMWGToolsModel PTACotisonONE:StrArr[0] TWO:StrArr[0]];
        }
        self.footerView.titleLabel.text = [NSString stringWithFormat:@"%@进口成本%@（元/吨）",_titlestr,footerStr];
    }
}
-(EIBMRateToolFooterView *)footerView
{
    if (!_footerView) {
        _footerView = [[[NSBundle mainBundle] loadNibNamed:@"RateToolFooterView" owner:self options:nil] lastObject];
    }
    return _footerView;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,0, 0) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = self.footerView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kWhiteColor;
    }
    return _tableView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    return self.styleArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    EIBMRateToolTFCell*cell = [tableView dequeueReusableCellWithIdentifier:@"RateToolTFCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.styleArr[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
