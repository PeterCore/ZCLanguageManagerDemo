//
//  UILabel+Language.h
//  QXDriver
//
//  Created by zhangchun on 2017/12/1.
//  Copyright © 2017年 千夏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCLanguageConfigueration.h"
#import "ZCLanguageMakeModel.h"
@interface UILabel (Language)

@property(nonatomic,strong)ZCLanguageMakeAttributeModel *attributeModel;

-(ZCConfiguerationLanguageBlock)makeLanguage;
-(ZCConfiguerationMutableAttributeLanguageBlock)makeAttributeLanguage;
//-(ZCConfiguerationLanguageMakeAttributeBlock)makeAttributeModel;
-(void)makeAttributeModel:(void(^)(ZCLanguageMakeAttributeModel *attributeModel))block;
-(void)switchLanguage;
-(void)switchLanguageAttribute;

@end
