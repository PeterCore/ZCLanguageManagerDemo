//
//  UILabel+Language.m
//  QXDriver
//
//  Created by zhangchun on 2017/12/1.
//  Copyright © 2017年 comp. All rights reserved.
//

#import "UILabel+Language.h"
#import "NSObject+Language.h"
#import "ZCLanguageManager.h"
#import "ZCAttributedStringLabelTool.h"
//#import <objc/runtime.h>
@interface UILabel (ZCLanguage)
@property(nonatomic,copy)NSString *isAttributedString;
@end

@implementation UILabel (Language)

-(ZCLanguageMakeAttributeModel*)attributeModel{
    ZCLanguageMakeAttributeModel *attributeModel = objc_getAssociatedObject(self, @selector(attributeModel));
    if (!attributeModel) {
        attributeModel = [[ZCLanguageMakeAttributeModel alloc] init];
    }
    return attributeModel;
}

-(void)setAttributeModel:(ZCLanguageMakeAttributeModel *)attributeModel{
    objc_setAssociatedObject(self, @selector(attributeModel), attributeModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString*)isAttributedString{
    NSString *attribute = objc_getAssociatedObject(self, @selector(isAttributedString));
    if (!attribute) {
        attribute = @"NO";
    }
    return attribute;
}

-(void)setIsAttributedString:(NSString *)isAttributedString{
    objc_setAssociatedObject(self, @selector(isAttributedString), isAttributedString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


-(void)makeAttributeModel:(void (^)(ZCLanguageMakeAttributeModel *))block{
    ZCLanguageMakeAttributeModel *attributeModel = [[ZCLanguageMakeAttributeModel alloc] initWithView:self];
    if (block) {
        block(attributeModel);
    }
    [attributeModel configuerationDataSource];
    [[ZCLanguageManager shareManager] addControls:self];

}

/**
 ** only switch language text
 **/
/*-(ZCConfiguerationLanguageBlock)makeLanguage{
    ZCConfiguerationLanguageBlock languageBlock = ZCConfiguerationLanguageBlock(languageKey){
        NSAssert(languageKey&&languageKey.length, @"languageKey must not to be null");
        if (languageKey) {
            self.languageKey = languageKey;
        }
        LanguageType languageType = [[ZCLanguageManager shareManager] fetchLanguage];
        if (!languageType) {
            languageType = LanguageType_default;
        }
        NSString *language = [[ZCLanguageManager shareManager] readLanguageWithKey:self.languageKey languageType:languageType];
        if (!language || !language.length) {
            self.text = languageKey;
        }
        else
            self.text = language;
        self.isAttributedString = @"NO";
        [[ZCLanguageManager shareManager] addControls:self];
        return self;
    };
    return languageBlock;
    
}

-(ZCConfiguerationMutableAttributeLanguageBlock)makeAttributeLanguage{

    ZCConfiguerationMutableAttributeLanguageBlock LanguageAttributeBlock = ZCConfiguerationMutableAttributeLanguageBlock(attribute){
        NSAssert(attribute.string&&attribute.string.length, @"attribue.string must not to be null");
        self.languageKey = attribute.string;
        NSRange range = NSMakeRange(0, attribute.string.length);
        NSDictionary *dictionary = [attribute attributesAtIndex:0 effectiveRange:&range];
        LanguageType languageType = [[ZCLanguageManager shareManager] fetchLanguage];
        if (!languageType) {
            languageType = LanguageType_default;
        }
        NSString *language = [[ZCLanguageManager shareManager] readLanguageWithKey:self.languageKey languageType:languageType];
        NSInteger length = language.length;
        range = NSMakeRange(0, length);
        attribute = [[NSMutableAttributedString alloc] initWithString:language];
        [attribute addAttributes:dictionary range:range];
        self.attributedText = attribute;
        self.isAttributedString = @"YES";
        [[ZCLanguageManager shareManager] addControls:self];
        return self;
    };
    return LanguageAttributeBlock;
}*/


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
    if (self.attributeModel.fontSize) {
        CGFloat fontSize = scale * self.attributeModel.fontSize;
        NSString *fontName = self.font.fontName;
        self.font = [UIFont fontWithName:fontName size:fontSize];
    }
    else if (self.attributeModel.attributeString){
        LanguageType languageType = [[ZCLanguageManager shareManager] fetchLanguage];
        if (!languageType) languageType = LanguageType_default;
        NSString *language = [[ZCLanguageManager shareManager] readLanguageWithKey:self.languageKey languageType:languageType];
        [[ZCAttributedStringLabelTool shareManager] managerAttributeWithNSMutableAttributedString:self.attributeString label:self language:language];
    }
}


-(void)switchLanguage
{
    LanguageType languageType = [[ZCLanguageManager shareManager] fetchLanguage];
    if (!languageType) {
        languageType = LanguageType_default;
    }
    NSString *language = [[ZCLanguageManager shareManager] readLanguageWithKey:self.languageKey languageType:languageType];
    if (!self.attributeModel.attributeString) {
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
        self.attributeModel.attributeString = attribute;
    }
}

-(void)dealloc{
    [[ZCLanguageManager shareManager] removeControlWithHash:self.hash];
}
@end
