//
//  UIScrollView+FXRefresh.m
//  FXDistributionSystem
//
//  Created by HMRL on 2018/4/8.
//  Copyright © 2018年 huaxiang. All rights reserved.
//

#import "UIScrollView+FXRefresh.h"
#import "MJRefresh.h"
#import <SwiftProjectKit-Swift.h>


@implementation UIScrollView (FXRefresh)

- (void)addPullDownReloadWithTarget:(id)target action:(SEL)action
{
    
    //动画代码
    //    MJChiBaoZiHeader *header = [MJChiBaoZiHeader headerWithRefreshingTarget:target refreshingAction:action];
    //
    //  隐藏时间
    //    header.lastUpdatedTimeLabel.hidden = YES;
    //
    // 隐藏状态
    //    header.stateLab el.hidden = YES;
    
    MJRefreshNormalHeader *header=[MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.textColor = [UIColor lightGrayColor];
//    [header.arrowView setImage:[UIImage imageNamed:@"dp_car_refresh"]];
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    header.stateLabel.hidden = YES;
    self.mj_header=header;
    
}

- (void)addAnimatePullDownReloadWithTarget:(id)target action:(SEL)action{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:target refreshingAction:action];
    UIImage *showImage = [UIImage imageNamed:@"dp_car_refresh"];
    if (showImage){
        // 设置普通状态的动画图片
        [header setImages:@[showImage] forState:MJRefreshStateIdle];
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        [header setImages:@[showImage] forState:MJRefreshStatePulling];
        // 设置正在刷新状态的动画图片
        [header setImages:@[showImage] forState:MJRefreshStateRefreshing];
    }
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    header.stateLabel.hidden = YES;
    // 设置header
    self.mj_header = header;
}

- (void)addPullUpLoadMoreWithTarget:(id)target action:(SEL)action
{
    
    MJRefreshAutoStateFooter *foot=[MJRefreshAutoStateFooter footerWithRefreshingTarget:target refreshingAction:action];
    //动画代码
    //MJChiBaoZiFooter *foot=[MJChiBaoZiFooter footerWithRefreshingTarget:target refreshingAction:action];
    // foot.refreshingTitleHidden=YES;
    
    // 隐藏状态
    //foot.stateLabel.hidden = NO;
    foot.stateLabel.textColor = MJRefreshLabelTextColor;
    
    self.mj_footer = foot;
//        self.mj_footer.automaticallyHidden = NO;
    self.mj_footer.hidden = YES;
}

- (void)beginReload
{
    [self.mj_header beginRefreshing];
}

- (void)beginLoadMore
{
    [self.mj_footer beginRefreshing];
}

- (void)endLoad
{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

- (void)canLoadMore
{
    self.mj_footer.hidden = NO;
    [self.mj_footer resetNoMoreData];
}

- (void)canNotLoadMore
{
    
    [self.mj_footer endRefreshingWithNoMoreData];
    self.mj_footer.hidden = NO;


}

@end
