//
//  YFShopCell.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/6/22.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class YFShopCell: UICollectionViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    //pss_赞，不一定要代码设定Label的透明度，可以使得颜色本身有透明度
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
