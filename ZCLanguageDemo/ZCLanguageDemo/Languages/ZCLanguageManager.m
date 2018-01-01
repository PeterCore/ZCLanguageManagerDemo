//
//  ZCLanguageManager.m
//  QXDriver
//
//  Created by zhangchun on 2017/12/1.
//  Copyright © 2017年 zhangchun. All rights reserved.
//

#import "ZCLanguageManager.h"
#import "NSObject+Language.h"
#import "UILabel+Language.h"
#import "UIButton+Language.h"
@interface ZCLanguageManager()
@property(nonatomic,strong)NSString *fileName;
@property(nonatomic,strong)NSMutableDictionary *controls;
@property(nonatomic,strong)NSRecursiveLock *recusiveLock;
@property(nonatomic,strong)NSDictionary *languageDatas;
//@property(nonatomic,strong)dispatch_queue_t queue_t;
@end
@implementation ZCLanguageManager

static ZCLanguageManager *__manager = nil;
+(instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager = [[[self class] alloc] init];
    });
    return __manager;
}

-(instancetype)init{
    if (self = [super init]) {
        self.fileName = @"ZCLanguage";
        self.controls = [NSMutableDictionary dictionary];
        self.recusiveLock = [[NSRecursiveLock alloc] init];
        self.languageDatas = [[NSMutableDictionary alloc] init];
       // self.queue_t = dispatch_queue_create([@"switch language queue_t" UTF8String], DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}


-(void)switchLanguageType:(LanguageType)type completionBlock:(void (^)(BOOL))completionBlock{
    
    [self saveLanguageType:type];
    __block NSInteger index = 0;
    [self.controls enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        UIView *view = (UIView*)obj;
        [self lock];
        [view switchLanguage];
        if (index == self.controls.allKeys.count-1) {
            if (completionBlock) {
                completionBlock(YES);
            }
        }
        index++;
        [self unlock];
    }];
    
}


-(void)switchLanguageFont:(LanguageFont)font completionBlock:(void (^)(BOOL))completionBlock{
    __block NSInteger index = 0;
    [self.controls enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        UIView *view = (UIView*)obj;
        [self lock];
        [view switchLanguageFont:font];
        if (index == self.controls.allKeys.count-1) {
            if (completionBlock) {
                completionBlock(YES);
            }
        }
        index++;
        [self unlock];
      
    }];
   
    
}


-(void)addControls:(UIView*)control{
    NSString *hashKey = [NSString stringWithFormat:@"%ld",control.hash];
    id exist_control = [self.controls objectForKey:hashKey];
    if (!exist_control) {
        [self.controls setObject:control forKey:hashKey];
    }
}

-(void)removeControlWithHash:(NSUInteger)hash
{
    NSString *hasKey = [NSString stringWithFormat:@"%ld",hash];
    id exist_control = [self.controls objectForKey:hasKey];
    if (exist_control) {
        [self.controls removeObjectForKey:hasKey];
    }
}

-(id)fetchControlWithHash:(NSUInteger)hash{
    NSString *hasKey = [NSString stringWithFormat:@"%ld",hash];
    id exist_control = [self.controls objectForKey:hasKey];
    return exist_control;
}

-(void)configuerationWith_plistFile:(NSString *)fileName{
    self.fileName = fileName;
}

-(LanguageType)fetchLanguage{
    LanguageType defaultLanguageType = LanguageType_default;
    NSNumber *LanguageType_Number =  [[NSUserDefaults standardUserDefaults] objectForKey:kLanguageKey];
    if (!LanguageType_Number) {
        [self saveLanguageType:defaultLanguageType];
    }
    else defaultLanguageType = [LanguageType_Number integerValue];
    return defaultLanguageType;
}

-(void)saveLanguageType:(LanguageType)type{
    [[NSUserDefaults standardUserDefaults]setObject:@(type) forKey:kLanguageKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(void)saveLanguageFontScale:(CGFloat)scale{
    [[NSUserDefaults standardUserDefaults]setObject:@(scale) forKey:kFontSize];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(CGFloat)fetchLanguageFontSize{
    CGFloat scale = 1.0;
    NSNumber *LanguageFontSize_Number =  [[NSUserDefaults standardUserDefaults] objectForKey:kFontSize];
    if (!LanguageFontSize_Number) {
        [self saveLanguageFontScale:scale];
    }
    else scale = floorf([LanguageFontSize_Number floatValue]*100)/100;
    return scale;
}

-(NSString*)readLanguageWithKey:(NSString *)key languageType:(LanguageType)type{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:self.fileName ofType:@"plist"];
    if (!self.languageDatas.allKeys.count) {
        self.languageDatas = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    }
    NSArray *languageList = self.languageDatas[key];
    NSString *language = languageList[type];
    return language;
}


-(void)lock{
    [self.recusiveLock lock];
}

-(void)unlock{
    [self.recusiveLock unlock];
}

@end
