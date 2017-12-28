//
//  ZCLanguageMakeModel.h
//  QXDriver
//
//  Created by zhangchun on 2017/12/1.
//  Copyright © 2017年 zhangchun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZCLanguageMakeModel : NSObject
@property(nonatomic,strong)NSString *text;
@property(nonatomic,strong)UIFont   *font;
@property(nonatomic,strong)UIColor  *color;
@property(nonatomic,strong)NSString *fontName;

-(instancetype)initWithView:(UIView*)view;
-(void)configuerationDataSource;
@end


@interface ZCLanguageMakeAttributeModel : ZCLanguageMakeModel
@property(nonatomic,assign)NSTextAlignment textAlignemt;
@property(nonatomic,strong)NSMutableAttributedString *attributeString;
@property(nonatomic,assign)CGFloat fontSize;
@end
