//
//  ButterflyStateHeaderView.m
//  ButterflyChooseDifferentStateDemo
//
//  Created by XiangTaiMini on 2017/2/23.
//  Copyright © 2017年 Butterfly. All rights reserved.
//

#import "ButterflyStateHeaderView.h"
#import "NSString+Size.h"

static const CGFloat slideViewheight = 2;
static const CGFloat bottomLineViewheight = 1;

@interface ButterflyStateHeaderView ()

@property (nonatomic , strong) NSMutableArray *buttons;  // 存放按钮的数组
@property (nonatomic, weak) UIScrollView *scrollView; // 底部数据多时，用于滑动的滚动图
@property (nonatomic , weak) UIView *bottomSlideView; // 底部滑动view
@property (nonatomic , weak) UIView *bottomLineView;  // 底部分割线

@end
@implementation ButterflyStateHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    
    }
    return self;
}

#pragma mark - 创建视图
-(void)setupViews {
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, self.frame.size.height)];
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIView *bottomLineView = [[UIView alloc] init];
    bottomLineView.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:bottomLineView];
    self.bottomLineView = bottomLineView;
    
    UIView *bottomSlideView = [[UIView alloc] init];
    bottomSlideView.backgroundColor = [UIColor orangeColor];
    [scrollView addSubview:bottomSlideView];
    self.bottomSlideView = bottomSlideView;
    
    for (int i = 0; i < self.titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        if (i == 0) {  // 默认第一个为选中状态
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:button];
        // 把按钮存放在数组中，以便其他地方取出使用
        [self.buttons addObject:button];
    }
}

#pragma mark - 按钮点击事件
-(void)buttonClick:(UIButton *)sender {
    
    for (UIButton *button in self.buttons) {
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [sender setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTitleColor" object:self userInfo:@{@"selectbtn":sender}];
    
    [UIView animateWithDuration:0.5 animations:^{

        CGFloat slideLineW = [sender.currentTitle stringSizeWithFont:[UIFont systemFontOfSize:self.fontSize]].width;
        self.bottomSlideView.frame = CGRectMake(sender.center.x - slideLineW / 2, sender.frame.size.height - slideViewheight, slideLineW, slideViewheight);
    } completion:^(BOOL finished) {
        
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(butterflyStateHeaderViewItemSelectIndex:)]) {
        [self.delegate butterflyStateHeaderViewItemSelectIndex:sender.tag];
    }
}

-(void)changeColor:(NSNotification *)notification {
    NSDictionary *dict = notification.userInfo;
    
    for (UIButton *allBtn in self.buttons) {
        [allBtn setTitleColor:self.defaultTitleColor forState:UIControlStateNormal];
    }
    UIButton *button = dict[@"selectbtn"];
    [button setTitleColor:self.selectTitleColor forState:UIControlStateNormal];
}

-(void)setTitles:(NSArray *)titles {
    _titles = titles;
    [self setupViews];
}

-(void)setFontSize:(CGFloat)fontSize {
    _fontSize = fontSize;
    for (UIButton *button in self.buttons) {
        button.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
    }
}

-(void)setDefaultTitleColor:(UIColor *)defaultTitleColor {
    _defaultTitleColor = defaultTitleColor;
    for (UIButton *button in self.buttons) {
        [button setTitleColor:defaultTitleColor forState:UIControlStateNormal];
    }
}

-(void)setSelectTitleColor:(UIColor *)selectTitleColor {
    
    _selectTitleColor = selectTitleColor;
    
    if (self.buttons) {
        UIButton *firstBtn = self.buttons.firstObject;
        [firstBtn setTitleColor:selectTitleColor forState:UIControlStateNormal];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"changeTitleColor" object:nil];
}

-(void)setBottomSlideViewColor:(UIColor *)bottomSlideViewColor {
    _bottomSlideViewColor = bottomSlideViewColor;
    self.bottomSlideView.backgroundColor = bottomSlideViewColor;
}

#pragma mark - 通过最大数量，布局视图的显示
-(void)setRowMaxCount:(NSInteger)rowMaxCount {
    _rowMaxCount = rowMaxCount;
    
    NSInteger i = 0;
    for (UIButton *button in self.buttons) {
        NSInteger tempCount;
        if (self.buttons.count > rowMaxCount) { // 如果数组的数量大于一行最大数量，则屏幕中显示最大数量的个数，可滑动
            tempCount = rowMaxCount;
        } else {
            tempCount = self.buttons.count;
        }
        CGFloat slideLineW;
        if (i == 0) {
            slideLineW = [button.currentTitle stringSizeWithFont:[UIFont systemFontOfSize:self.fontSize]].width;
        }
        
        CGFloat buttonW = Screen_Width / tempCount;
        CGFloat buttonH = self.frame.size.height;
        button.frame = CGRectMake(buttonW * i, 0, buttonW, buttonH);
        self.bottomSlideView.frame = CGRectMake((buttonW - slideLineW) / 2, buttonH - slideViewheight, slideLineW, slideViewheight);
        
        self.scrollView.contentSize = CGSizeMake(buttonW * self.buttons.count, self.frame.size.height);
        
        self.bottomLineView.frame = CGRectMake(0, buttonH - bottomLineViewheight, buttonW * self.buttons.count, bottomLineViewheight);
        i++;
    }
}

-(NSMutableArray *)buttons {
    
    if (!_buttons) {
        _buttons = [[NSMutableArray alloc] init];
    }
    return _buttons;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
