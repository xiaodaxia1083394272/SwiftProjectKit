//
//  YFBlurtView.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/7/3.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class YFBlurtView: UIView,UIScrollViewDelegate/*,UITableViewDataSource,UITableViewDelegate */{

    var changeRate = CGFloat(0)
    var headerImgHeight = CGFloat(0)
    var iconHeight = CGFloat(0)
    /**
     *  图片url
     */
    var imgUrl = ""
    var name = ""
    // 1.定义一个闭包类型
    //格式: typealias 闭包名称 = (参数名称: 参数类型) -> 返回值类型
    typealias SelectRowAction = (_ indexPath: NSIndexPath) -> Void
    //2. 声明一个变量
    var selectAction: SelectRowAction?
    /**
     *  图片
     */
    var imageView:UIImageView!
    var headImage:UIImageView!
    var mTableView:UITableView!
    /**
     *  自定义添加的view
     */
    var otherView:UIView!
    /**
     *  放大比例
     */
    var scale = CGFloat(0)
    /**
     *  名字label
     */
    var label:UILabel!
    
    convenience init(frame:CGRect,headerImgHeight:CGFloat, iconHeight:CGFloat, block:@escaping SelectRowAction) {
        self.init(frame: frame)
        self.headerImgHeight = (headerImgHeight == 0  ? self.frame.size.height * 0.382 : headerImgHeight)
        self.iconHeight = (iconHeight == 0  ? self.frame.size.height * 0.382  : iconHeight);
        selectAction = block
        //默认值
        changeRate = (self.frame.size.width / self.frame.size.height)

    }
    
    func setupContentView(){
        //pss_赞，这个用断点来判断异常的做法好
       assert(self.headerImgHeight >= self.iconHeight && self.iconHeight > 0, "图片高度应当大于头像高度，头像高度应当大于零")
        // imageView
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.headerImgHeight))
        imageView.contentMode = .scaleAspectFill
        self.scale =  self.imageView.frame.size.width / self.imageView.frame.size.height;
        imageView.image = UIImage.init(named: "blurtView1.jpg");
        // 20 左右 R  模糊图片
//        [imageView setImageToBlur:imageView.image blurRadius:20 completionBlock:nil];
//
//        // headImage
//        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - self.iconHeight) / 2, (self.headerImgHeight - self.iconHeight) / 2, self.iconHeight, self.iconHeight)];
//        icon.backgroundColor = [UIColor yellowColor];
//        icon.image = [UIImage imageNamed:@"blurtView1.jpg"];
//        icon.layer.cornerRadius = self.iconHeight * 0.5;
//        icon.clipsToBounds = YES;
//        self.headImage = icon;
    }
    

}
extension YFBlurtView{
  
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
}





