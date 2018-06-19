//
//  HWCollectionViewCell.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/6/19.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class HWCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderWidth = 5;
        self.layer.borderColor = UIColor.white.cgColor;
        self.layer.cornerRadius = 5;
    }
    
    var index :String = ""{
        
        //2.监听属性已经发生改变：以及改变
        didSet(index){
            
            self.label.text = index
        }
    }

}


