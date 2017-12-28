//
//  UITextField+Language.h
//  QXDriver
//
//  Created by zhangchun on 2017/12/6.
//  Copyright © 2017年 zhangchun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCLanguageConfigueration.h"
#import "NSObject+Language.h"
#import "ZCLanguageManager.h"
@interface UITextField (Language)
-(ZCConfiguerationMutableAttributeLanguageBlock)makeAttributePlaceHolder;
-(ZCConfiguerationLanguageBlock)makePlaceHolder;
@end
