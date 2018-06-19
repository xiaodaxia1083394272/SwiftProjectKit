//
//  SPHorizontalScrollViewController.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/6/19.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class SPHorizontalScrollViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    var collectionView : UICollectionView?
    
    fileprivate lazy var data :[String] = {
        
        var data = [String]()
        for i in 0..<20 {
            
          data .append("\(i)")
        }
        return data;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建UICollectionView
        let layout = HWLineLayout();
        collectionView = UICollectionView(frame:CGRect(x: 0, y: 100, width: kScreenW, height: 200), collectionViewLayout: layout)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(UINib(nibName: "HWCollectionViewCell", bundle:nil), forCellWithReuseIdentifier:"cell")
        view.addSubview(self.collectionView!)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath)
//        cell.index(self.data(indexPath.item)
        
        return cell
    }


}
