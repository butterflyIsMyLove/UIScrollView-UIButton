//
//  ButterflyStateHeaderView.h
//  ButterflyChooseDifferentStateDemo
//
//  Created by XiangTaiMini on 2017/2/23.
//  Copyright © 2017年 Butterfly. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ButterflyStateHeaderViewDelegate <NSObject>

-(void)butterflyStateHeaderViewItemSelectIndex:(NSInteger)index;

@end
@interface ButterflyStateHeaderView : UIView

@property (nonatomic , weak) id <ButterflyStateHeaderViewDelegate> delegate;

@property (nonatomic, nullable, strong) NSArray *titles;
@property (nonatomic, assign) CGFloat fontSize; // 字体大小(默认为15)
@property (nonatomic, nullable, strong) UIColor *defaultTitleColor; // 默认的标题颜色（默认为blackColor）
@property (nonatomic, nullable, strong) UIColor *selectTitleColor; // 选中的标题颜色(设置选中颜色之前一定要先设置默认颜色) （默认为orangeColor）
@property (nonatomic, nullable, strong) UIColor *bottomSlideViewColor; // 底部滑动条颜色  （默认为orangeColor）
@property (nonatomic , assign) NSInteger rowMaxCount; // 一行显示的最大个数（必传，建议为了美观传入小于7的数字）

@end
