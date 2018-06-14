//
//  SPTestKingfisherVC.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/5/30.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit
import Kingfisher

class SPTestKingfisherVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func clickShowImageBtn(_ sender: Any) {
        
        //加载网络图片
        let imageURL = URL(string: "http://img.taopic.com/uploads/allimg/110729/1830-110H916410651.jpg")
        imageView.kf.setImage(with: ImageResource(downloadURL: imageURL!))
        
        //默认图片的写法
//        imageView.kf.setImage(with: ImageResource(downloadURL: imageURL!), placeholder: UIImage(named: "test"), options: nil, progressBlock: nil, completionHandler: nil)

    }
    
}
