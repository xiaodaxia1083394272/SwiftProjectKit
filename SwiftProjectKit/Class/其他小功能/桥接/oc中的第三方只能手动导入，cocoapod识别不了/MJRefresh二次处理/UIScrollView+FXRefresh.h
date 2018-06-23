//
//  UIScrollView+FXRefresh.h
//  FXDistributionSystem
//
//  Created by HMRL on 2018/4/8.
//  Copyright © 2018年 huaxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (FXRefresh)

- (void)addAnimatePullDownReloadWithTarget:(id)target action:(SEL)action;

//添加下拉刷新效果
- (void)addPullDownReloadWithTarget:(id)target action:(SEL)action;

//添加上拉加载更多效果
- (void)addPullUpLoadMoreWithTarget:(id)target action:(SEL)action;

//开始刷新
- (void)beginReload;

//开始加载更多
- (void)beginLoadMore;

//结束刷新和加载
- (void)endLoad;

//设置能加载更多
- (void)canLoadMore;

//设置不能加载更多
- (void)canNotLoadMore;

@end
