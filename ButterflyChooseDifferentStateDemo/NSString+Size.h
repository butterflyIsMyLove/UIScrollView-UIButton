//
//  NSString+Size.h
//  ButterflyChooseDifferentStateDemo
//
//  Created by XiangTaiMini on 2017/3/23.
//  Copyright © 2017年 Butterfly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Size)


/**
 根据字体算出字符串的size

 @param font 字体
 @return CGSize
 */
-(CGSize)stringSizeWithFont:(UIFont *)font;

@end
