//
//  Person.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/5/30.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class Person: NSObject {
    //MARK:1.类的构造函数
    //在swift开发中，如果在对象函数中，用到成员属性，那么self.可以省略
    //注意：如果在函数中，有和成员属性重名的局部变量，那么self.不能省略
    //如果想保留原构造函数，则不要把其写出来，否则就会被覆盖
//    init() {
//
//    }
//    init(name : String , age : Int) {
//        self.name = name
//        self.age = age
//    }
     init(dict : [String : Any]) {
        if  let name = dict["name"] as? String{
            
            self.name = name
        }
    }
    
    //MARK:2.类的基本特性---属性
    /*
     
     33.1类的定义
     （oc中定义类，又是声明，又是实现的，而且一般在创建的时候就会继承了父类了，swift可以不继承，直接一个关键词“class”就搞掂了。第二，虽然都有默认的构造函数，但是oc中定义类时属性可以不初始化，而swift中定义类则要属性初始化）
     
     33.2类的属性定义
     swift中的类属性跟oc有个很大的区别是，oc中的属性有strong，assign等关键词进行修饰，而swift中统一成变量或常量（一般是变量 ）没有了关键词，多分成“存储属性”，“计算属性”，"类属性"(后两者少用）
     */

    //如果属性是值类型，则初始化为空值
    //如果属性是对象类型，则初始化为nil值
    //1，存储属性：用于存储实例的常量&变量
    var age  :Int = 0
    var view :UIView?
    var mathScore :Double = 0.0
    var chineseScore : Double = 0.0
    //2，计算属性：通过某种方式计算得来结果的属性，就是计算属性-->其实计算属性也称之为只读属性，用于取代oc中的只读属性关键字
    var averageScore :Double {
        /*
         set {
         }

         get {
         return (chineseScore + mathScore) * 0.5
         }
         set get 方法一般可以省略
         */
        return (chineseScore + mathScore) * 0.5
        //3类属性：和整个类相关,并且是通过类名进行访问
//        var courseCount :Int = 0
//        //给类扩展函数
//        //在oc中写的很多没有参数的方法，在swift中可以写成计算属性
//        func getAverageScore()  -> Double {
//            return (chineseScore + mathScor) * 0.5
//        }
    }
    //MARK:3.类的属性监听器
    /*
     oc中监听属性的变化是通过重写set的方式，而oc属性中的@property已经帮忙实现了get ，set方法，但是swift已经不存在@property了。要监听属性的变化则要通过属性监听器（willSet,didSet)
     */
    
    var name :String = ""{
        //监听属性即将发生改变：还没有改变
        willSet(newName){
        }
        /*
         newName参数名是乱起的，没用到的话，可以不写
         willSet{
         }
         */
        //2.监听属性已经发生改变：以及改变
        didSet(oldName){
        }
    }
    //MARK:4.kvc赋值
//    如果有多属性的情况下，可以借助kvc简写进行构造赋值
    /*
     使用KVC条件
     1>必须继承自NSObject
     2>必须在构造函数中，先调用super.init()
     3>调用setValuesForKeys
     4>如果字典中某一个key没有对应的属性，则需要重写setValue forUnderfinedKey方法(反正用kvc进行构造赋值的话，顺手写上这一句准没错，
     5>举个例子
     init(dict : [String : Any]) {
         if  let name = dict["name"] as? String{
     
         self.name = name
         }
       super.init()
       setValuesForKeys(dict)
     }
     override func setValue (_ value : Any?,forUnderfinedKey key : String){}
     */
    //MARK:5.类的析构函数（类似oc的dealloc）
    /*
     deinit {
     
       print ("Person -----deinit")
     }
     */
    

}
