//
//  ZCLanguageConfigueration.h
//  QXDriver
//
//  Created by zhangchun on 2017/12/1.
//  Copyright © 2017年 zhangchun. All rights reserved.
//

#ifndef ZCLanguageConfigueration_h
#define ZCLanguageConfigueration_h
#import <Foundation/Foundation.h>
#import "ZCLanguageMakeModel.h"
#import <objc/runtime.h>
static NSString *const kLanguageKey = @"kLanguageKey";
static NSString *const kFontSize    = @"kFontSize";

static CGFloat LittleScale = 0.8;
static CGFloat StandardScale = 1.0;
static CGFloat BigScale = 1.2;

typedef NS_ENUM(NSInteger , LanguageType){
    LanguageType_ChineseSimple = 0,
    LanguageType_EngLish = 1,
    LanguageType_ChineseComplex = 2,
    LanguageType_default = LanguageType_ChineseSimple,
};

typedef NS_ENUM(NSInteger , LanguageFont){
    LanguageFont_Little,
    LanguageFont_Standard,
    LanguageFont_Big,
};


typedef UIView*(^ZCConfiguerationLanguageMakeAttributeBlock)(ZCLanguageMakeModel *makerAttribute);
#define ZCConfiguerationLanguageMakeAttributeBlock(makerAttribute) ^UIView*(ZCLanguageMakeModel *makerAttribute)

typedef UIView*(^ZCConfiguerationLanguageBlock)(NSString *languageKey);
#define ZCConfiguerationLanguageBlock(languageKey) ^UIView* (NSString *languageKey)

typedef UIView*(^ZCConfiguerationFontLanguageBlock)(UIFont *font);
#define ZCConfiguerationFontLanguageBlock(font) ^UIView* (UIFont *font)

typedef UIView*(^ZCConfiguerationFontSizeLanguageBlock)(CGFloat fontSize);
#define ZCConfiguerationFontSizeLanguageBlock(fontSize) ^UIView* (CGFloat fontSize)

typedef UIView*(^ZCConfiguerationFontNameLanguageBlock)(NSString *fontName);
#define ZCConfiguerationFontNameLanguageBlock(fontName) ^UIView* (NSString *fontName)

typedef UIView*(^ZCConfiguerationColorLanguageBlock)(UIColor *color);
#define ZCConfiguerationColorLanguageBlock(color) ^UIView* (UIColor *color)

typedef UIView*(^ZCConfiguerationMutableAttributeLanguageBlock)(NSMutableAttributedString *attribute);
#define ZCConfiguerationMutableAttributeLanguageBlock(attribute) ^UIView* (NSMutableAttributedString *attribute)

typedef UIView*(^ZCConfiguerationButtonLanguageBlock)(NSString *title, UIControlState state);
#define ZCConfiguerationButtonLanguageBlock(title,state) ^UIView* (NSString *title, UIControlState state)




#endif /* ZCLanguageConfigueration_h */
