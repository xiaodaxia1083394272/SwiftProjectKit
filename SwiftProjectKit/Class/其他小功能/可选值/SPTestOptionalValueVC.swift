//
//  SPTestOptionalValueVC.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/6/21.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class SPTestOptionalValueVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       test3()
    }
    
    func test1(){
       /*
        1.可选类型的原理揣测：
        可选类型也是一个泛型集合（目前接触到的泛型集合有数组和字典），有点像Any，估计这也是其能赋nil的原因，因此，可选类型也是要指定其“元素”的类型，比如，
       2. 可选类型的全写为：*/
//        var name :Optional<String> = nil
        //3.nil只能赋值给可选值，下面的写法是错误的
//        let name = nil
        //4.语法糖的写法
        let name :String? = nil
    
    }
    
    func test2(){
        //可选值为nil强制解包直接闪
        let name :String? = nil
        print(name!)
    }
    
    func test3(){
        //安全解包
        let name :String? = nil
        if name != nil {
            print(name!)
        }
        /*
         可选绑定
         pss_如果说这个可选值用得不多，上面那种写法简便，
         如果这个值用得很多，那么下面可选绑定这种写法比较简便，
         虽然引入了一个新的变量，但是不用像上面那样每个都加上叹号
         
         
         2.可选绑定（固定格式）：该语法用于可选类型，使我们使用起来可选类型更加方便（也就方便那么一丢丢）
         1>判断name是否有值，如果没有值，则直接不执行{}
         2>如果name有值，那么系统会自动对可选类型进行解包，并且将解包后的结果赋值给前面的tempName
         */
        
        if  let tempName = name{
            print(tempName)
            //ps:貌似我发现还是要强解一下的
        }
        //目前最简写法
        if  let name = name {
            print (name)
        }
        
    }
    
    func test4(){
        
        /*
         28.4可选类型的应用(可选类型的参数都可以传nil，有可能为空的都是可选类型，也就是说因为可选类型的大行其道，swift在某种程度上讲，已经没有什么绝对值可言），转，取，等有可能为空的操作得到的值基本都是可选类型
         */
        
//        1.类型转换：如将字符串转换成Int类型
        //转换的时候是可选类型
        let num : Int?  =  Int("str")
        
//        2.根据文件名称获取文件的路径
        let path : String? = Bundle.main.path(forResource:"123.plist", ofType:nil)
        
//        3.将字符串转成NSURL
        //如果字符串中有中文，那么就是转化不成功，返回的结果为nil。
        let url : URL? = URL(string : "http://www.test.cn")
        
//        4.从字典中取出元素也是可选类型
        let dic : [String : Any] = ["name" : "xiaoming"]
        let value : Any? = dic["name"]
        //换言之，swift中的Any不包括nil，这很重要，注意了哈
    }
}
