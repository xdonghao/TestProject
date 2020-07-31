//
//  UITextView+Placeholder.h
//  AAzuche
//
//  Created by XX on 2018/3/30.
//  Copyright © 2018年 AAChuxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Placeholder)

/**
 textView placeholder text
 */
@property (nonatomic ,copy)NSString *placeholder;
/**
 textView placeholder textColor
  @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1]}
 */
@property (nonatomic ,strong)NSDictionary *placeholderAttributes;
/**
 the max inputLenth
 */
@property (nonatomic ,assign)NSInteger maxInputLength;

@end
