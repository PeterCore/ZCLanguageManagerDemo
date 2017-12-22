//
//  UITextField+Language.m
//  QXDriver
//
//  Created by zhangchun on 2017/12/6.
//  Copyright © 2017年 千夏. All rights reserved.
//

#import "UITextField+Language.h"

@interface UITextField(Language_Private)
@property(nonatomic,copy)NSString *isAttributedString;
@end

@implementation UITextField (Language_Private)

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

-(ZCConfiguerationMutableAttributeLanguageBlock)makeAttributePlaceHolder{
    ZCConfiguerationMutableAttributeLanguageBlock attributeBlock = ZCConfiguerationMutableAttributeLanguageBlock(attribute){
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
    return attributeBlock;
    
}

-(ZCConfiguerationLanguageBlock)makePlaceHolder{
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
            self.placeholder = languageKey;
        }
        else
            self.placeholder = language;
        self.isAttributedString = @"NO";
        [[ZCLanguageManager shareManager] addControls:self];
        return self;
    };
    return languageBlock;
}


-(void)switchLanguage
{
    LanguageType languageType = [[ZCLanguageManager shareManager] fetchLanguage];
    if (!languageType) {
        languageType = LanguageType_ChineseSimple;
    }
    NSString *language = [[ZCLanguageManager shareManager] readLanguageWithKey:self.languageKey languageType:languageType];
    if ([self.isAttributedString isEqualToString:@"NO"]) {
        self.placeholder = language;
    }
    else{
        NSInteger length = language.length;
        NSRange range = NSMakeRange(0, self.attributedText.string.length);
        NSDictionary *dictionary = [self.attributedText attributesAtIndex:0 effectiveRange:&range];
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:language];
        range = NSMakeRange(0, length);
        [attribute addAttributes:dictionary range:range];
        self.placeholder.attributeString = attribute;
    }
}

-(void)dealloc{
    [[ZCLanguageManager shareManager] removeControlWithHash:self.hash];
}

@end
