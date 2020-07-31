//
//  UIImage+Extension.h
//  黑马微博
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (UIImage *) resizableImageWithName:(NSString *)imageName;
- (UIImage*) scaleImageWithSize:(CGSize)size;
+ (UIImage*) imageWithColor: (UIColor*) color;
- (UIImage*) selectImage:(UIImage *)image scaleImageSize:(CGSize)size;
@end
