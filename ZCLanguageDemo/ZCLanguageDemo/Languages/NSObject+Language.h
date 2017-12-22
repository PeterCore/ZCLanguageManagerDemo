//
//  NSObject+Language.h
//  QXDriver
//
//  Created by zhangchun on 2017/12/1.
//  Copyright © 2017年 千夏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCLanguageMakeModel.h"

@interface NSObject (Language)
@property(nonatomic,strong,setter=setLanguageKey:)NSString *languageKey;
@property(nonatomic,strong,setter=setAttributeString:)NSMutableAttributedString *attributeString;
@property(nonatomic,strong)ZCLanguageMakeModel *makerAttribute;
-(void)switchLanguage;
//-(void)swithLanguage;
@end
