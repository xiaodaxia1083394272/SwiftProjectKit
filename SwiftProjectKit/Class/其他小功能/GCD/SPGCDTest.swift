//
//  SPGCDTest.swift
//  SwiftProjectKit
//
//  Created by HMRL on 2018/6/24.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit
//pss_参考：
class SPGCDTest: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        test1()
    }
    
    func test0(){
        //MARK:队列
        /*
         DispatchQueue字面意思就是派发列队，主要是管理需要执行的任务，
         任务以闭包或者DispatchWorkItem的方式进行提交.
         列队中的任务遵守FIFO原则。
         列队可以是串行也可以是并发，串行列队按顺序执行，
         并发列队会并发执行任务，但是我们并不知道具体任务的执行顺序。
         
         
         列队的分类
         系统列队
         
         主列队
         let mainQueue = DispatchQueue.main
         
         全局列队
         let globalQueue = DispatchQueue.global()
         
         用户创建列队
         创建自己的列队，简单的方式就是指定列队的名称即可
         let queue = DispatchQueue(label: "com.conpanyName.queue")
         这样的初始化的列队有着默认的配置项,默认的列队是串行列队。便捷构造函数如下
         public convenience init(label: String, qos: DispatchQoS = default, attributes: DispatchQueue.Attributes = default, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency = default, target: DispatchQueue? = default)
         我们也可以自己显示设置相关属性，创建一个并发列队
         let label = "com.conpanyName.queue"
         let qos = DispatchQoS.default
         let attributes = DispatchQueue.Attributes.concurrent
         let autoreleaseFrequnecy = DispatchQueue.AutoreleaseFrequency.never
         let queue = DispatchQueue(label: label, qos: qos, attributes: attributes, autoreleaseFrequency: autoreleaseFrequnecy, target: nil)
         */

    }
    //MARK:以下为队列的参数
    func test1(){
        //MARK:1.label：列队的标识符，能够方便区分列队进行调试
    }
    func test2(){
        //MARK:2.优先级QoS（Quality of Service）
        /*
         //pss_恕我直言，优先级这东西并不好用，从下面打印的log情况看
         优先级最高的userInitiated也并不是说一定在前面执行，只是总的来说，比较靠前
         
         //pss_吐槽，QoS叫做优先级(priority)?!,什么鬼！这命名能不能靠谱点？！
         qos：列队的优先级，其值如下：
         public struct DispatchQoS : Equatable {
         public static let background: DispatchQoS
         public static let utility: DispatchQoS
         public static let `default`: DispatchQoS
         public static let userInitiated: DispatchQoS
         public static let userInteractive: DispatchQoS
         public static let unspecified: DispatchQoS
         }
         优先级由最低的background到最高的userInteractive共五个，还有一个为定义的unspecified.
         
         background：最低优先级，等同于DISPATCH_QUEUE_PRIORITY_BACKGROUND. 用户不可见，比如：在后台存储大量数据
         
         utility：优先级等同于DISPATCH_QUEUE_PRIORITY_LOW，可以执行很长时间，再通知用户结果。比如：下载一个大文件，网络，计算
         
         default：默认优先级,优先级等同于DISPATCH_QUEUE_PRIORITY_DEFAULT，建议大多数情况下使用默认优先级
         
         userInitiated：优先级等同于DISPATCH_QUEUE_PRIORITY_HIGH,需要立刻的结果
         
         .userInteractive：用户交互相关，为了好的用户体验，任务需要立马执行。使用该优先级用于UI更新，事件处理和小工作量任务，在主线程执行。
         
         Qos指定了列队工作的优先级，系统会根据优先级来调度工作，越高的优先级能够越快被执行，但是也会消耗功能，所以准确的指定优先级能够保证app有效的使用资源。
         */
        
        DispatchQueue.global(qos: .background).async {
            for i in 1...5 {
                print("background: \(i)")
            }
        }
        DispatchQueue.global(qos: .default).async {
            for i in 1...5 {
                print("default: \(i)")
            }
        }
        DispatchQueue.global(qos: .userInteractive).async {
            for i in 1...5 {
                print("userInteractive: \(i)")
            }
        }

    }
    
    func test3(){
        //MARK:3.attributes：列队的属性，也可以说是类型，即是并发还是串行。
        //pss_除了系统提供的global和main，这个一般在自定义属性的时候比较常见
        /*
         attributes是一个结构体并遵守OptionSet协议，所以传入的参数可以为[.option1, .option2]
         public struct Attributes : OptionSet {
         public let rawValue: UInt64
         public init(rawValue: UInt64)
         public static let concurrent: DispatchQueue.Attributes
         public static let initiallyInactive: DispatchQueue.Attributes
         }
         默认：列队是串行的
         
         .concurrent：列队是并发的
         
         .initiallyInactive：列队不会自动执行，需要开发中手动触发
         
         autoreleaseFrequency：自动释放频率，有些列队会在执行完任务之后自动释放，有些是不会自动释放的，需要手动释放。

         */
    }
    
    func test(){
        //MARK: 常见使用
        //1.异步执行回主线程写法
        DispatchQueue.global().async {
            print("async do something\(Thread.current)")
            DispatchQueue.main.async {
                print("come back to main thread\(Thread.current)")
            }
        }
    }
    
}
