//
//  YFWaterflowLayout.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/6/22.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

/*
 pss_原理，
 0>.代理输入值，pss_赞，通过代理来输入值，虽然形式了点，不过，解耦性强，特别适合需要大量处理才能得到的传入值
 1>.准备设置（获取所有的item布局属性数组，基本必做）
 2>.自定义或者修改item的样式
 3>.返回item的size
 4>.根据新的布局去刷新UI
 5>.滑动刷UI的权限为YES
 */

@objc protocol YFWaterflowLayoutDelegate : class {
    func waterflowLayout(waterflowLayout:YFWaterflowLayout,indexPath:NSIndexPath,itemWidth:CGFloat) -> CGFloat
    /**
     *  返回四边的间距, 默认是UIEdgeInsetsMake(10, 10, 10, 10)
     */
    @objc optional func insetsInWaterflowLayout(_ waterflowLayout:YFWaterflowLayout) -> UIEdgeInsets
    /**
     *  返回最大的列数, 默认是3
     */
    @objc optional func maxColumnsInWaterflowLayout(_ waterflowLayout:YFWaterflowLayout) ->NSInteger
    /**
     *  返回每行的间距, 默认是10
     */
    @objc optional func rowMarginInWaterflowLayout(_ waterflowLayout:YFWaterflowLayout) ->CGFloat
    /**
     *  返回每列的间距, 默认是10
     */
    @objc optional func columnMarginInWaterflowLayout(_ waterflowLayout:YFWaterflowLayout) ->CGFloat
}

/** 每一行的最大列数 */
let  YFDefaultMaxColumns : NSInteger = 3;
/** 每一行的间距 */
let YFDefaultRowMargin : CGFloat = 10.0;
/** 每一列的间距 */
let YFDefaultColumnMargin : CGFloat = 10.0;
/** 上下左右的间距 */
let YFDefaultInsets : UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10);

class YFWaterflowLayout: UICollectionViewFlowLayout {
    
    weak var delegate : YFWaterflowLayoutDelegate?
    /** 存放每一列的最大Y值(整体高度) */
    var maxYs : [CGFloat]!
    var attrsArray : [UICollectionViewLayoutAttributes]!
    
}

extension YFWaterflowLayout {
    
//    1>
    override func prepare(){
       //初始化最大y值数组
        self.maxYs.removeAll()
        //pss_吐槽，swift中的变量名跟方法名不能一样，不像oc！,（像这种冲突的，其实可以在前面加self）
        let maxColumnsa = self.maxColumns()
        for _ in 0..<maxColumnsa {
           self.maxYs.append(self.insets().top)
        }
        // 计算所有cell的布局属性
        self.attrsArray.removeAll()
        let count = self.collectionView?.numberOfItems(inSection: 0)
        if count != nil {
            for i in 0..<count!{
                let indexPath : NSIndexPath = NSIndexPath.init(item: i, section: 0)
                let attrs : UICollectionViewLayoutAttributes = self.layoutAttributesForItem(at:indexPath as IndexPath)!
                self.attrsArray .append(attrs)
            }
        }
     
    }
    /**
     * 2> indexPath这个位置对应cell的布局属性
     */
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//
//        // 每一列之间的间距
//        let columnMargin  = self.columnMargin();
//        // 每一行之间的间距
//        let rowMargin = self.rowMargin();
//
//        // CollectionView的尺寸
//
//        let collectionWidth = self.collectionView?.bounds.size.width;
//        var collectionW = CGFloat(0.0)
//        if collectionWidth != nil{
//            collectionW = collectionWidth!
//        }
//
//        let maxColumns = self.maxColumns();
//        let insets = self.insets();
//        // item(cell)的宽度
//        let a = collectionW - insets.left - insets.right - (maxColumns - 1)
//        let b =   a  * columnMargin
//        let itemW = a / maxColumns;
//
//        // 询问代理. indexPath这个位置item的高度
////        let itemH = [self.delegate waterflowLayout:self heightForItemAtIndexPath:indexPath itemWidth:itemW];
//        let itemH = self.waterflowLayout()
//
//        // 创建属性
//        UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//
//        // 设置位置和尺寸
//        CGFloat minMaxY = [self.maxYs[0] doubleValue]; // 最短那一列 的 最大Y值
//        int minColumn = 0; // 最短那一列 的 列号
//        for (int i = 1; i < maxColumns; i++) {
//            CGFloat maxY = [self.maxYs[i] doubleValue];
//            if (maxY < minMaxY) {
//                minMaxY = maxY;
//                minColumn = i;
//            }
//        }
//
//        CGFloat itemX = insets.left + minColumn * (itemW + columnMargin);
//        CGFloat itemY = minMaxY + rowMargin;
//        attrs.frame = CGRectMake(itemX, itemY, itemW, itemH);
//
//        // 累加这一列的最大Y值
//        self.maxYs[minColumn] = @(CGRectGetMaxY(attrs.frame));
//
//        return attrs;
//    }
//
//    /*
//     5>
//     当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。
//     */
//    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//
//        return true
//    }
}

extension YFWaterflowLayout{
//    0>
    //MARK: - 私有方法(通过代理获得数字)
    func maxColumns() -> NSInteger {
       return (delegate?.maxColumnsInWaterflowLayout?(self))!
       return YFDefaultMaxColumns;
    }
    
    func rowMargin() -> CGFloat {
        return (delegate?.rowMarginInWaterflowLayout?(self))!
        return YFDefaultRowMargin;
    }

    func columnMargin() -> CGFloat {
        return (delegate?.columnMarginInWaterflowLayout?(self))!
        return YFDefaultColumnMargin;
    }

    func insets() -> UIEdgeInsets {
        return (delegate?.insetsInWaterflowLayout?(self))!
        return YFDefaultInsets;
    }
}
