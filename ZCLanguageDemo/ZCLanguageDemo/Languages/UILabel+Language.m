//
//  UILabel+Language.m
//  QXDriver
//
//  Created by zhangchun on 2017/12/1.
//  Copyright © 2017年 zhangchun. All rights reserved.
//

#import "UILabel+Language.h"
#import "ZCLanguageManager.h"
#import "ZCAttributedStringLabelTool.h"
//#import <objc/runtime.h>
@interface UILabel (ZCLanguage)
@property(nonatomic,copy)NSString *isAttributedString;
@end

@implementation UILabel (Language)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        NSLog(@"----Class is %@",NSStringFromClass([self class]));

        SEL originalSelectorDidAppear = @selector(didMoveToSuperview);
        SEL swizzledSelectorDidAppear = @selector(kb_didMoveToSuperview);
        
        Method originalMethodAppear = class_getInstanceMethod(class, originalSelectorDidAppear);
        Method swizzledMethodAppear = class_getInstanceMethod(class, swizzledSelectorDidAppear);
        
        BOOL willAddMethod =
        class_addMethod(class,
                        originalSelectorDidAppear,
                        method_getImplementation(swizzledMethodAppear),
                        method_getTypeEncoding(swizzledMethodAppear));
        
        if (willAddMethod) {
            class_replaceMethod(class,
                                swizzledSelectorDidAppear,
                                method_getImplementation(originalMethodAppear),
                                method_getTypeEncoding(originalMethodAppear));
        } else {
            method_exchangeImplementations(originalMethodAppear, swizzledMethodAppear);
        }
        
    });
}


-(void)kb_didMoveToSuperview{
    if ([NSStringFromClass([self class]) isEqualToString:@"UIButtonLabel"]) {
        return;
    }
    if (!self.languageKey&&!self.languageKey.length) {
        if (self.text) {
            self.languageKey = self.text;
        }
        else self.languageKey = [self.attributedText.string copy];
    }
    LanguageType languageType = [[ZCLanguageManager shareManager] fetchLanguage];
    NSString *language = [[ZCLanguageManager shareManager] readLanguageWithKey:self.languageKey languageType:languageType];
    
    if (!language.length&&!language) {
        language = self.languageKey;
    }
    NSAssert(language&&language.length, @"language is not null");
    if (self.attributedText) {
        [[ZCAttributedStringLabelTool shareManager] managerAttributeWithNSMutableAttributedString:[self.attributedText mutableCopy] label:self language:language];
    }
    else{
        if (!self.orginFontSize) {// first init fontSize
            if (!self.font.pointSize) {
                self.font = [UIFont systemFontOfSize:12];
            }
            self.orginFontSize = [[NSNumber alloc] initWithFloat:self.font.pointSize];
        }
        CGFloat scale = [[ZCLanguageManager shareManager] fetchLanguageFontSize];
        CGFloat fontSize = scale * floorf([self.orginFontSize floatValue]*100/100);
        self.font = self.font.fontName.length?[UIFont fontWithName:self.font.fontName size:fontSize]:[UIFont systemFontOfSize:fontSize];
        self.text = language?language:@"";
    }
    [[ZCLanguageManager shareManager] addControls:self];
}


-(void)switchLanguageFont:(LanguageFont)font{
    CGFloat scale = 0;
    switch (font) {
        case LanguageFont_Little:
            scale = LittleScale;
            break;
        case LanguageFont_Standard:
            scale = StandardScale;
            break;
        case LanguageFont_Big:
            scale = BigScale;
            break;
        default:
            break;
    }
    [[ZCLanguageManager shareManager]saveLanguageFontScale:scale];
    if (!self.attributedText) {
        CGFloat fontSize = scale * floorf([self.orginFontSize floatValue]*100/100);
        NSString *fontName = self.font.fontName;
        if(fontSize != self.font.pointSize)
           self.font = [UIFont fontWithName:fontName size:fontSize];
    }
    else if (self.attributedText){
        LanguageType languageType = [[ZCLanguageManager shareManager] fetchLanguage];
        if (!languageType) languageType = LanguageType_default;
        NSString *language = [[ZCLanguageManager shareManager] readLanguageWithKey:self.languageKey languageType:languageType];
        [[ZCAttributedStringLabelTool shareManager] managerAttributeWithNSMutableAttributedString:[self.attributedText mutableCopy] label:self language:language];
    }
}


-(void)switchLanguage
{
    LanguageType languageType = [[ZCLanguageManager shareManager] fetchLanguage];
    if (!languageType) {
        languageType = LanguageType_default;
    }
    NSString *language = [[ZCLanguageManager shareManager] readLanguageWithKey:self.languageKey languageType:languageType];
    if (!self.attributedText) {
        self.text = language;
    }
    else{
        NSInteger length = language.length;
        NSRange range = NSMakeRange(0, self.attributedText.string.length);
        NSDictionary *dictionary = [self.attributedText attributesAtIndex:0 effectiveRange:&range];
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:language];
        range = NSMakeRange(0, length);
        [attribute addAttributes:dictionary range:range];
        self.attributedText = attribute;
        //self.attributeModel.attributeString = attribute;
    }
}

-(void)dealloc{
    [[ZCLanguageManager shareManager] removeControlWithHash:self.hash];
}
@end
