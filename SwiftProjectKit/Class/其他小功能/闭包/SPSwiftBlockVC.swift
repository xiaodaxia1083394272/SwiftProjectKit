//
//  SPSwiftBlockVC.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/5/28.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit
//pss_参考：http://www.runoob.com/swift/swift-closures.html
/*
 闭包(Closures)是自包含的功能代码块，
 可以在代码中使用或者用来作为参数传值。
 Swift 中的闭包与 C 和 Objective-C 中的代码块（blocks）以及其他一些编程语言中的 匿名函数比较相似。
 全局函数和嵌套函数其实就是特殊的闭包。
 闭包的形式有：
 全局函数（有名字但不能捕获任何值。）
 嵌套函数（有名字，也能捕获封闭函数内的值。）
 闭包表达式（无名闭包，使用轻量级语法，可以根据上下文环境捕获值。）
 
 Swift中的闭包有很多优化的地方:
 
 根据上下文推断参数和返回值类型
 从单行表达式闭包中隐式返回（也就是闭包体只有一行代码，可以省略return）
 可以使用简化参数名，如$0, $1(从0开始，表示第i个参数...)
 提供了尾随闭包语法(Trailing closure syntax)
 */

class SPSwiftBlockVC: UIViewController {
    
    var testSwiftBlcokObjcet : SPTestSwiftBlcokObjcet?
    
    @IBOutlet weak var testLB: UILabel!
    
    @IBAction func clickTestBtn(_ sender: Any) {
        /*
         self.一般是可以省略掉，但以下情况除外
         1> 如果该方法中有局部变量和成员属性有歧义（名称相同）
         2> 在闭包中使用成员属性
         对于闭包中的循环引用的问题：
         如果所在的类对闭包强引用了，就有必要使用weakself，并且是以可选链的方式
         
         pss_swift的强类型特性也是够了，
         定个weakSelf一定要指定是那个控制器，
         给个UIViewController还不行
         */
        weak var weakSelf : SPSwiftBlockVC? = self
        //1.这种貌似是尾随闭包的写法
//        testSwiftBlcokObjcet?.loadData({ (jsonData : String) in
//
//            weakSelf?.testLB.text = jsonData
//        })
        //2.这种是拆开来的写法，比较灵活，比较常用
        let a = SPTestSwiftBlcokObjcet()
        a.callBackBlock { (str,two) in
            weakSelf?.testLB.text = str
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //实例对象
        testSwiftBlcokObjcet = SPTestSwiftBlcokObjcet()
        //测试
        test9()
    }
 
}

extension SPSwiftBlockVC{
    
     func test1(){
        //MARK:swift闭包
        /*
         语法
         以下定义了一个接收参数并返回指定类型的闭包语法：
         {(parameters) -> return type in
         statements
         }
         实例
         //pss_疑，这个写法也是简洁得让我有点难以置信，就一个大括号就写出闭包了？
         也太666了吧，果然swift中的闭包至少从写法上比oc的强大太多了。我估计这种写法集合了：
         1.根据上下文推断参数和返回值类型
         2.从单行表达式闭包中隐式返回（也就是闭包体只有一行代码，可以省略return）
         也就是说下面的写法，把参数，返回值，return的形式全都给隐藏，省略掉了，所以写得那么简洁！
         let studname = { print("Swift 闭包实例。") }
         studname()
         以上程序执行输出结果为：
         Swift 闭包实例。
         */
        
        /*
         以下闭包形式接收两个参数并返回布尔值：
         {(Int, Int) -> Bool in
         Statement1
         Statement 2
         ---
         Statement n
         }
         实例*/
//         import Cocoa
 
         let divide = {(val1: Int, val2: Int) -> Int in
             return val1 / val2
         }
         let result = divide(200, 20)
         print (result)
//         以上程序执行输出结果为:
//         10
 
    }
    
     func test2(){
        /*
         //MARK: 闭包表达式
         闭包表达式是一种利用简洁语法构建内联闭包的方式。 闭包表达式提供了一些语法优化，使得撰写闭包变得简单明了。
         
         sorted 方法
         Swift 标准库提供了名为 sorted(by:) 的方法，
         会根据您提供的用于排序的闭包函数将已知类型数组中的值进行排序。
         排序完成后，sorted(by:) 方法会返回一个与原数组大小相同，
         包含同类型元素且元素已正确排序的新数组。
         原数组不会被 sorted(by:) 方法修改。
         sorted(by:)方法需要传入两个参数：
         已知类型的数组
         闭包函数，该闭包函数需要传入与数组元素类型相同的两个值，并返回一个布尔类型值来表明当排序结束后传入的第一个参数排在第二个参数前面还是后面。如果第一个参数值出现在第二个参数值前面，排序闭包函数需要返回 true，反之返回 false。
         实例
         */
        let names = ["AT", "AE", "D", "S", "BE"]
        
        let reversed = names.sorted(by: backwards)
        
        print(reversed)
        /*
         以上程序执行输出结果为：
         ["S", "D", "BE", "AT", "AE"]
         如果第一个字符串 (s1) 大于第二个字符串 (s2)，
         backwards函数返回true，表示在新的数组中s1应该出现在s2前。
         对于字符串中的字符来说，"大于" 表示 "按照字母顺序较晚出现"。
         这意味着字母"B"大于字母"A"，字符串"S"大于字符串"D"。
         其将进行字母逆序排序，"AT"将会排在"AE"之前
         */
    }
    
    func test3(){
        //MARK:参数名称缩写
        /*
         Swift 自动为内联函数提供了参数名称缩写功能，
         您可以直接通过$0,$1,$2来顺序调用闭包的参数。
         */
        let names = ["AT", "AE", "D", "S", "BE"]
//        $0和$1表示闭包中第一个和第二个String类型的参数。
        let reversed = names.sorted( by: { $0 > $1 } )
        print(reversed)
//        以上程序执行输出结果为：
//        ["S", "D", "BE", "AT", "AE"]
        /*
         如果你在闭包表达式中使用参数名称缩写,
         您可以在闭包参数列表中省略对其定义,
         并且对应参数名称缩写的类型会通过函数类型进行推断。in 关键字同样也可以被省略.
         //pss_吐槽，swift中的闭包写法简直就是各种省略
         */
    }
    
    func test4(){
        //MARK:运算符函数
        /*
         实际上还有一种更简短的方式来撰写上面例子中的闭包表达式。
         Swift 的String类型定义了关于大于号 (>) 的字符串实现，
         其作为一个函数接受两个String类型的参数并返回Bool类型的值。
         而这正好与sort(_:)方法的第二个参数需要的函数类型相符合。
         因此，您可以简单地传递一个大于号，
         Swift可以自动推断出您想使用大于号的字符串函数实现：
         */
        
        let names = ["AT", "AE", "D", "S", "BE"]
        let reversed = names.sorted(by: >)
        print(reversed)
    }
    
    func test5(){
        //MARK:尾随闭包
        /*
         尾随闭包是一个书写在函数括号之后的闭包表达式，
         函数支持将其作为最后一个参数调用。
         
         func someFunctionThatTakesAClosure(closure: () -> Void) {
         // 函数体部分
         }
         
         // 以下是不使用尾随闭包进行函数调用
         someFunctionThatTakesAClosure({
         // 闭包主体部分
         })
         
         // 以下是使用尾随闭包进行函数调用
         someFunctionThatTakesAClosure() {
         // 闭包主体部分
         }
         实例：
         */
        let names = ["AT", "AE", "D", "S", "BE"]
        //尾随闭包
        let reversed = names.sorted() { $0 > $1 }
        print(reversed)
        /*
         sort() 后的 { $0 > $1} 为尾随闭包。
         以上程序执行输出结果为：
         ["S", "D", "BE", "AT", "AE"]
         注意： 如果函数只需要闭包表达式一个参数，
         当您使用尾随闭包时，您甚至可以把()省略掉。
         reversed = names.sorted { $0 > $1 }
         */
        
    }
    
    func test6(){
        //MARK:捕获值
        /*
         闭包可以在其定义的上下文中捕获常量或变量。
         即使定义这些常量和变量的原域已经不存在，闭包仍然可以在闭包函数体内引用和修改这些值。
         Swift最简单的闭包形式是嵌套函数，也就是定义在其他函数的函数体内的函数。
         嵌套函数可以捕获其外部函数所有的参数以及定义的常量和变量。
         看这个例子：
         func makeIncrementor(forIncrement amount: Int) -> () -> Int {
          var runningTotal = 0
             func incrementor() -> Int {
               runningTotal += amount
               return runningTotal
             }
          return incrementor
         }
         一个函数makeIncrementor ，它有一个Int型的参数amout, 并且它有一个外部参数名字forIncremet，意味着你调用的时候，必须使用这个外部名字。返回值是一个()-> Int的函数。
         函数题内，声明了变量runningTotal 和一个函数incrementor。
         incrementor函数并没有获取任何参数，但是在函数体内访问了runningTotal和amount变量。这是因为其通过捕获在包含它的函数体内已经存在的runningTotal和amount变量而实现。
         由于没有修改amount变量，incrementor实际上捕获并存储了该变量的一个副本，而该副本随着incrementor一同被存储。
         所以我们调用这个函数时会累加：
         */
        let incrementByTen = makeIncrementor(forIncrement: 10)
        
        // 返回的值为10
        print(incrementByTen())
        
        // 返回的值为20
        print(incrementByTen())
        
        // 返回的值为30
        print(incrementByTen())
        /*
         以上程序执行输出结果为
         10
         20
         30
         */
        //MARK:闭包是引用类型
        /*
         上面的例子中，incrementByTen是常量，
         但是这些常量指向的闭包仍然可以增加其捕获的变量值。
         这是因为函数和闭包都是引用类型。
         无论您将函数/闭包赋值给一个常量还是变量，
         您实际上都是将常量/变量的值设置为对应函数/闭包的引用。
         上面的例子中，incrementByTen指向闭包的引用是一个常量，而并非闭包内容本身。
         这也意味着如果您将闭包赋值给了两个不同的常量/变量，两个值都会指向同一个闭包：
         */
        let alsoIncrementByTen = incrementByTen
        // 返回的值也为40
        print(alsoIncrementByTen())
    }
    
    func test7(){
        //MARK:闭包 之 Sort函数（排序）
        // Sort函数
        /*
         在OC中对一个数组排序，以及字典的排序往往都是自己写一个函数去实现。swift中就不用再自己再去做这样的事了。Swift提供了sort函数，可以让数组和字典很方便的实现排序。
         */
        var a = ["2","1","3"]

        a.sort { (s1, s2) -> Bool in
            return s1 > s2
        }
        print(a)//打印结果：["3", "2", "1"]
    }
    
    func test8(){
        //MARK:闭包 之 map函数
        /*
         1. Swift 的 Array 类型有一个 map 方法，其获取一个闭包表达式作为其唯一参数。数组中的每一个元素调用一次该闭包函数，并返回该元素所映射的值(也可以是不同类型的值)。
         */
        
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        let numbers = [16, 58, 510]
        
        // 将numbers的数字转换成英文字符串数组
        let strings = numbers.map {
            number -> String in
            var number = number//将常量转成变量，因为我们要在下面做循环递除。这两个number是不同的，按Option左键点击可看到，它们一个是var，一个let的，编译器会作区分
            var output = ""
            repeat {
                output = digitNames[number % 10]! + output
                number /= 10
            } while number > 0
            return output
        }
        // strings 常量被推断为字符串类型数组，即 [String]
        // 其值为 ["OneSix", "FiveEight", "FiveOneZero"]
        
       let two = numbers.map({
            $0 + 10
        })
        print(two)
    }
    
    func test9(){
        //MARK:$0,$1
        /*
         swift自动为闭包提供参数名缩写功能，可以直接通过$0和$1等来表示闭包中的第一个第二个参数，并且对应的参数类型会根据函数类型来进行判断。如下代码：
         
         不使用$0 $1这些来代替
         */
        let numbers = [1,2,5,4,3,6,8,7]
        let sortNumbers = numbers.sorted(by: { (a, b) -> Bool in
            return a < b
        })
        print("numbers -" + "\(sortNumbers)")
//        使用$0,$1
        let numbers2 = [1,2,5,4,3,6,8,7]
        let sortNumbers2 = numbers2.sorted(by: {$0 < $1})
        print("numbers2 -" + "\(sortNumbers2)")
        /*
         可以发现使用$0、$1的话，参数类型可以自动判断，并且in关键字也可以省略，也就是只用写函数体就可以了
         */
    }
    
}

//MARK:协助函数
extension SPSwiftBlockVC{
    
    // 使用普通函数(或内嵌函数)提供排序功能,闭包函数类型需为(String, String) -> Bool。
    func backwards(s1: String, s2: String) -> Bool {
        return s1 > s2
    }
    
    func makeIncrementor(forIncrement amount: Int) -> () -> Int {
        var runningTotal = 0
        func incrementor() -> Int {
            runningTotal += amount
            return runningTotal
        }
        return incrementor
    }
}
