//
//  HWLineLayout.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/6/19.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class HWLineLayout: UICollectionViewFlowLayout {

    /*
     当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。
     */
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        
        return true
    }
    
    /**
     * 只要布局刷新了,首先会调用这个方法
     */
    override func prepare() {
        let inset = ((self.collectionView?.bounds.size.width)! - self.itemSize.width) * 0.5
        self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset)
    }
    
    /**
     *  控制collectionView停止滚动时所停留的最终位置
     *
     *  @param proposedContentOffset 默认情况下,collectionView停止滚动时的contentOffset值
     *  @param velocity              速度
     *
     *  @return collectionView停止滚动时的最终contentOffset值
     */
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        // 计算屏幕最中间的x值
        let screenCenterX = proposedContentOffset.x + (self.collectionView?.bounds.size.width)! * 0.5
        
        // 计算屏幕的可见范围
        var visiableRect = CGRect()
         visiableRect.origin = proposedContentOffset;
        visiableRect.size = (self.collectionView?.bounds.size)!;
        
        // 获得可见范围内的cell的布局属性
        let array = super.layoutAttributesForElements(in: visiableRect)
        var minDelta = MAXFLOAT;
        for  attrs in array! {// 遍历所有cell的布局属性
           
            print("attrs.center.x = \(attrs.center.x), screenCenterX = \(screenCenterX), attrs.center.x - screenCenterX = \(attrs.center.x - screenCenterX)")
            if (CGFloat(abs(attrs.center.x - screenCenterX)) < CGFloat(abs(minDelta))){
                
                minDelta = Float(CGFloat(attrs.center.x - screenCenterX));
                print("minDelta  =\(minDelta)")
            }else {
                print("应该不会运行到这里")
            }
        }
        return  CGPoint(x: CGFloat(Float(proposedContentOffset.x) + minDelta), y: proposedContentOffset.y)

        
    }
    
    /*
     UICollectionViewLayoutAttributes的作用: 设置cell的尺寸\透明度\形变属性
     */
    
    /**
     * 设置UICollectionView内部所有元素的布局参数
     *
     *  @return 数组中存放的都是UICollectionViewLayoutAttributes对象, 一个cell对应一个UICollectionViewLayoutAttributes对象
     */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let array = super.layoutAttributesForElements(in: rect);
        
        // 计算屏幕最中间的x值
        let screenCenterX = (self.collectionView?.contentOffset.x)! + (self.collectionView?.bounds.size.width)! * 0.5;
        
        
        // 可见范围
        for attrs in array! {
            let scale = 1.0 + 0.5 * (1.0 - abs(screenCenterX - attrs.center.x) / 200)
            print("screenCenterX = \(screenCenterX), attrs.center.x = \(attrs.center.x), abs= \(screenCenterX - attrs.center.x), scale = \(scale)")
            attrs.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        
        return array
        
    }
    
    
}
