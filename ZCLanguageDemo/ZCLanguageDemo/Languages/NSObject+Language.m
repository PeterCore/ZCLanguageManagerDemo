//
//  NSObject+Language.m
//  QXDriver
//
//  Created by zhangchun on 2017/12/1.
//  Copyright © 2017年 zhangchun. All rights reserved.
//

#import "NSObject+Language.h"
#import <objc/runtime.h>
//static  char kLanguageAttribute;

@implementation NSObject (Language)


-(NSNumber*)orginFontSize{
    NSNumber *orginFontSize = objc_getAssociatedObject(self, @selector(orginFontSize));
    if (!orginFontSize) {
        orginFontSize = [[NSNumber alloc] init];
        [self setOrginFontSize:orginFontSize];
    }
    return orginFontSize;
}

-(void)setOrginFontSize:(NSNumber *)orginFontSize{
    objc_setAssociatedObject(self, @selector(orginFontSize), orginFontSize, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString*)languageKey{
    NSString *languageKey = objc_getAssociatedObject(self, @selector(languageKey));
    if (!languageKey) {
        self.languageKey = languageKey;
    }
    return languageKey;
}

-(void)setLanguageKey:(NSString *)languageKey{
    objc_setAssociatedObject(self, @selector(languageKey), languageKey, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSMutableAttributedString*)attributeString{
    NSMutableAttributedString *attributeString = objc_getAssociatedObject(self, @selector(attributeString));
    if (!attributeString) {
        self.attributeString = attributeString;
    }
    return attributeString;
}

-(void)setAttributeString:(NSMutableAttributedString *)attributeString{
     objc_setAssociatedObject(self, @selector(attributeString), attributeString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(ZCLanguageMakeModel*)makerAttribute{
    ZCLanguageMakeModel *makerAttribute = objc_getAssociatedObject(self,@selector(makerAttribute));
    return makerAttribute;
}

-(void)setMakerAttribute:(ZCLanguageMakeModel *)makerAttribute{
    objc_setAssociatedObject(self, @selector(makerAttribute), makerAttribute, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)switchLanguage
{
    
}
-(void)switchLanguageFont:(LanguageFont)font{
    
}


@end
