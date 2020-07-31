//
//  UITextView+Placeholder.m
//  AAzuche
//
//  Created by XX on 2018/3/30.
//  Copyright © 2018年 AAChuxing. All rights reserved.
//

#import "UITextView+Placeholder.h"
#import <objc/runtime.h>

static const char placeholderKey = '\3';
static const char placeholderColorKey = '\4';
static const char placeholderLabelKey = '\5';
static const char maxInputLengthKey = '\6';
static UILabel *placeholderLabel;

@implementation UITextView (Placeholder)

+ (void)load {
    Method dealloc = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
    Method aa_dealloc = class_getInstanceMethod(self, @selector(aa_dealloc));
    method_exchangeImplementations(dealloc, aa_dealloc);
    
    Method initWithFrame = class_getInstanceMethod(self, NSSelectorFromString(@"initWithFrame:"));
    Method aa_initWithFrame = class_getInstanceMethod(self, @selector(aa_initWithFrame:));
    method_exchangeImplementations(initWithFrame, aa_initWithFrame);
    
    Method drawRect = class_getInstanceMethod(self, NSSelectorFromString(@"drawRect:"));
    Method aa_drawRect = class_getInstanceMethod(self, @selector(aa_drawRect:));
    method_exchangeImplementations(drawRect, aa_drawRect);
    
    Method setText = class_getInstanceMethod(self, NSSelectorFromString(@"setText:"));
    Method aa_setText = class_getInstanceMethod(self, @selector(aa_setText:));
    method_exchangeImplementations(setText, aa_setText);
    
    Method setFont = class_getInstanceMethod(self, NSSelectorFromString(@"setFont:"));
    Method aa_setFont = class_getInstanceMethod(self, @selector(aa_setFont:));
    method_exchangeImplementations(setFont, aa_setFont);
    
    Method setAttributedText = class_getInstanceMethod(self, NSSelectorFromString(@"setAttributedText:"));
    Method aa_setAttributedText = class_getInstanceMethod(self, @selector(aa_setAttributedText:));
    method_exchangeImplementations(setAttributedText, aa_setAttributedText);
}

- (void)drawRect:(CGRect)rect {
    
}

- (void)aa_drawRect:(CGRect)rect {
    if (self.hasText) {
        return;
    }
    /**
     placeholder文字的绘制情况跟自身的text 属性相关，
     所以要重写set方法去调用drawRect方法（setNeedsDisplay）
     **/
    self.placeholderAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],
                                   NSForegroundColorAttributeName:[UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1]};
    rect.origin.x = 5;
    rect.origin.y = 8;
    rect.size.width -= 2 * rect.origin.x;
    [self.placeholder drawInRect:rect withAttributes:self.placeholderAttributes];
}

- (instancetype)aa_initWithFrame:(CGRect)frame {
    [self aa_initWithFrame:frame];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aa_textViewDidChangeNotification:) name:UITextViewTextDidChangeNotification object:nil];
    return self;
}

- (void)aa_dealloc {
    if (self == [UITextView class]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    }
}

- (void)setPlacehoderLabel:(UILabel *)placehoderLabel {
    objc_setAssociatedObject(self, &placeholderLabelKey, placehoderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setPlaceholder:(NSString *)placeholder {
    objc_setAssociatedObject(self, &placeholderKey, placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsDisplay];
}

- (void)setPlaceholderAttributes:(NSDictionary *)placeholderAttributes {
    objc_setAssociatedObject(self, &placeholderColorKey, placeholderAttributes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsDisplay];
}

- (void)setMaxInputLength:(NSInteger)maxInputLength {
    objc_setAssociatedObject(self, &maxInputLengthKey, @(maxInputLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)maxInputLength {
    NSNumber *inputNumber = objc_getAssociatedObject(self, &maxInputLengthKey);
    return inputNumber.integerValue;
}

- (NSString *)placeholder {
    return objc_getAssociatedObject(self, &placeholderKey);
}

- (NSDictionary *)placeholderAttributes {
    return objc_getAssociatedObject(self, &placeholderColorKey);
}

- (UILabel *)placehoderLabel {
    return objc_getAssociatedObject(self, &placeholderLabelKey);
}

- (void)aa_setText:(NSString *)text {
    [self aa_setText:text];
    [self setNeedsDisplay];
}

- (void)aa_setAttributedText:(NSAttributedString *)attributedText {
    [self aa_setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)aa_setFont:(UIFont *)font {
    [self aa_setFont:font];
    [self setNeedsDisplay];
}

- (void)aa_textViewDidChangeNotification:(NSNotification *)notification {
    [self setNeedsDisplay];
    if (self.maxInputLength <= 0) {
        return;
    }
    NSString *InputMethodType = [[UIApplication sharedApplication]textInputMode].primaryLanguage;
    // 如果当前输入法为汉语输入法
    if ([InputMethodType isEqualToString:@"zh-Hans"]) {
        // 获取选中部分
        UITextRange *selectedRange = [self markedTextRange];
        //获取选中部分的偏移量, 此部分为用户未决定输入部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 当没有标记部分时截取字符串
        if (position == nil) {
            self.text = [self textViewCurrentText];
        }
    } else {
        self.text = [self textViewCurrentText];
    }
}

- (NSString *)textViewCurrentText {
    return self.text.length > self.maxInputLength ? [self.text substringToIndex:self.maxInputLength] : self.text;
}

@end
