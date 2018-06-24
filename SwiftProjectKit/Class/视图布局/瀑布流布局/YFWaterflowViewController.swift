//
//  YFWaterflowViewController.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/6/22.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit
//pss_吐槽，第三方库用到就要导入一次，swift的优势也不明显啊
import Kingfisher

class YFWaterflowViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,YFWaterflowLayoutDelegate {
    let CellId = "shop"
    var shops = [YFShop]()
    var collectionView : UICollectionView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "流水布局展示"
        // 初始化数据
        //pss_吐槽 被oc的addObjectsFromArray误导了，swift中的+针对单个数组其实不适用
         shops = YFShop.mj_objectArray(withFilename: "1.plist") as! [YFShop]
       
        // 创建布局
        let layout : YFWaterflowLayout = YFWaterflowLayout()
        layout.delegate = self;
        
        // 创建UICollectionView
        collectionView = UICollectionView(frame:self.view.bounds, collectionViewLayout: layout)
        collectionView?.dataSource = self
        collectionView?.backgroundColor = kWhiteColor
        collectionView?.delegate = self
        collectionView?.register(UINib(nibName: "YFShopCell", bundle:nil), forCellWithReuseIdentifier:CellId)
        view.addSubview(self.collectionView!)
        
        self.collectionView?.addPullDownReload(withTarget: self, action: #selector(YFWaterflowViewController.loadNewShops))
        self.collectionView?.addPullUpLoadMore(withTarget: self, action:#selector(YFWaterflowViewController.loadMoreShops))
        

    }
    
}

extension YFWaterflowViewController{
    
    @objc func loadNewShops(){
        let delay2 = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: delay2) {
            // 延迟执行
            /*
             pss_吐槽，本来想用
             [self.shops insertObjects:newShops atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newShops.count)]];
             这个方法的，不过swift中好像没有
             */
            let newShops = YFShop.mj_objectArray(withFilename: "2.plist") as! [YFShop]
            let original = self.shops
            self.shops = newShops + original
            self.collectionView?.reloadData()
            self.collectionView?.endLoad()
        }
    }
    
    @objc func loadMoreShops(){
        let delay2 = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: delay2) {
           let newShops = YFShop.mj_objectArray(withFilename: "3.plist") as! [YFShop]
            self.shops = self.shops + newShops
            self.collectionView?.reloadData()
            self.collectionView?.endLoad()
        }
    }
}

extension YFWaterflowViewController{
    
    func waterflowLayout(waterflowLayout: YFWaterflowLayout, indexPath: NSIndexPath, itemWidth: CGFloat) -> CGFloat {
        let shop : YFShop = self.shops[indexPath.item];
        return shop.h * itemWidth / shop.w;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.shops.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : YFShopCell = collectionView.dequeueReusableCell(withReuseIdentifier:CellId, for: indexPath) as! YFShopCell
        
        let shop : YFShop = self.shops[indexPath.item];
        cell.priceLabel.text = shop.price;
        
        cell.iconView.kf.setImage(with: ImageResource(downloadURL: URL(string: shop.img)!))
        
        return cell
    }
}
