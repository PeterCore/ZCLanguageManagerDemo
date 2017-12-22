//
//  ZCLanguageManager.h
//  QXDriver
//
//  Created by zhangchun on 2017/12/1.
//  Copyright © 2017年 千夏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCLanguageConfigueration.h"
@interface ZCLanguageManager : NSObject

+(instancetype)shareManager;
-(void)configuerationWith_plistFile:(NSString*)fileName;
-(void)switchLanguageType:(LanguageType)type;
-(void)saveLanguageType:(LanguageType)type;
-(NSString*)readLanguageWithKey:(NSString*)key languageType:(LanguageType)type;
-(LanguageType)fetchLanguage;
-(void)addControls:(UIView*)control;
-(void)removeControlWithHash:(NSUInteger)hash;
@end
