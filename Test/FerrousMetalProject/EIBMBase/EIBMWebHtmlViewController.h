//
//  WebHtmlViewController.h
//  DrivingSafety
//
//  Created by 董浩 on 15/11/1.
//  Copyright (c) 2015年 zhengkai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EIBMBaseViewController.h"
//WebView通用类
@interface EIBMWebHtmlViewController : EIBMBaseViewController
//标题
@property (nonatomic, copy)NSString *titleStr;
//网址
@property (nonatomic, copy)NSString *urlStr;
@end
