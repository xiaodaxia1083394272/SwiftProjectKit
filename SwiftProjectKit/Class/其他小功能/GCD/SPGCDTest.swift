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

        test14()
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
    
    func test4(){
        //MARK:DispatchWorkItem是用于帮助DispatchQueue来执行列队中的任务(oc 中可没有这东西）都是搞成对象，不过有两种使用方式：1.以参数的形式使用，2.以调起方法的形式
        //1.pss_将任务封装成对象，有点意思
        let item = DispatchWorkItem {
            DispatchQueue.main.async{
                print("testD")
            }
        }
        DispatchQueue.global().async(execute: item)
        
//        2.这里也可以使用DispatchWorkItem实例对象的perform方法执行任务
        let workItem = DispatchWorkItem {
            print("testW")
        }
        DispatchQueue.global().async {
            workItem.perform()
        }
//        3.也可以在初始化的时候指定更多的参数
        /*
         public struct DispatchWorkItemFlags : OptionSet, RawRepresentable {
         public let rawValue: UInt
         public init(rawValue: UInt)
         public static let barrier: DispatchWorkItemFlags
         public static let detached: DispatchWorkItemFlags
         public static let assignCurrentContext: DispatchWorkItemFlags
         public static let noQoS: DispatchWorkItemFlags
         public static let inheritQoS: DispatchWorkItemFlags
         public static let enforceQoS: DispatchWorkItemFlags
         }
         */
        let itemThree = DispatchWorkItem(qos: .default, flags: .barrier) {
            // do task
        }
    }
    
    func test5(){
        //MARK:执行任务结束通过nofify获得通知
        //pss_如果就一个任务完成之后的通知，没什么使用价值，除非多任务。
        let workItem = DispatchWorkItem {
            // do async task
            print(Thread.current)
        }
        
        DispatchQueue.global().async {
            workItem.perform()
        }
        
        workItem.notify(queue: DispatchQueue.main) {
            // update UI
            print(Thread.current)
        }
    }
    
    func test6(){
        //MARK:使用wait等待任务执行完成
        let workItem = DispatchWorkItem {
            sleep(5)
            print("done")
        }
        
        let queue = DispatchQueue(label: "queue", attributes: .concurrent)

        queue.async(execute: workItem)
        print("before waiting")
        workItem.wait()
        //pss_也就是说即使异步开了子线程也要等其执行完，主线程才能执行？（咋感觉就是有点鸡肋！）
        print("after waiting")
    }
    
    func test7(){
        //MARK:barrier
        /*
         假如我们有一个并发的列队用来读写一个数据对象，如果这个列队的操作是读，那么可以同时多个进行。如果有写的操作，则必须保证在执行写操作时，不会有读取的操作执行，必须等待写操作完成之后再开始读取操作，否则会造成读取的数据出错，经典的读写问题。这里我们就可以使用barrier
         */
        let item = DispatchWorkItem(qos: .default, flags: .barrier) {
            // write data
        }
        let dataQueue = DispatchQueue(label: "com.data.queue", attributes: .concurrent)
        dataQueue.async(execute: item)
        /*
         2.举个例子
         字典的读写操作
         通过在并发代码中使用barrier将能够保证写操作在所有读取操作完成之后进行，
         而且确保写操作执行完成之后再开始后续的读取操作
         */
         let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
         var dictionary: [String: Any] = [:]
        
         func set(_ value: Any?, forKey key: String) {
            // .barrier flag ensures that within the queue all reading is done
            // before the below writing is performed and
            // pending readings start after below writing is performed
            concurrentQueue.async(flags: .barrier) {
                dictionary[key] = value
            }
        }
        
         func object(forKey key: String) -> Any? {
            var result: Any?
            concurrentQueue.sync {
                result = dictionary[key]
            }
            
            // returns after concurrentQueue is finished operation
            // beacuse concurrentQueue is run synchronously
            return result
        }
    }
    
    func test8(){
        //MARK:延时处理
        /*
         使用asyncAfter来提交任务进行延迟。之前是使用dispatch_time,现在是使用DispatchTime对象表示。可以使用静态方法now获得当前时间，然后再通过加上DispatchTimeInterval枚举获得一个需要延迟的时间。注意：仅仅是用于在具体时间执行任务，不要在资源竞争的情况下使用。并且在主列队使用。
         */
        let delay = DispatchTime.now() + DispatchTimeInterval.seconds(5)
        DispatchQueue.main.asyncAfter(deadline: delay) {
            // 延迟执行
            print("延迟执行1")
        }
        //2.我们可以进一步简化，直接添加时间
        let delay2 = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: delay2) {
            // 延迟执行
            print("延迟执行2")
        }
        //3.因为在DispatchTime中自定义了“+”号。
//        public func +(time: DispatchTime, seconds: Double) -> DispatchTime
        //pss_这个表示看不懂
    }
    
    func test9(){
        //MARK:DispatchGroup(这个倒是挺常用的,不过挺麻烦的，因为还要同时使用：enter()和leave()成对； 信号量； notify函数）
        /*
         DispatchGroup用于管理一组任务的执行，
         然后监听任务的完成，进而执行后续操作。
         比如：同一个页面发送多个网络请求，等待所有结果请求成功刷新UI界面。
         （为了真正实现预期的效果，
         我们需要配合group的enter和leave两个函数。
         每次执行group.enter()表示一个任务被加入到列队组group中，
         此时group中的任务的引用计数会加1，
         当使用group.leave() ，表示group中的一个任务完成，
         group中任务的引用计数减1.当group列队组里面的任务引用计数为0时
         ，会通知notify函数，任务执行完成。注意：enter()和leave()成对出现的。）
         一般的操作如下：
         */
        let queue = DispatchQueue.global()
        let group = DispatchGroup()
        
        group.enter()
        queue.async(group: group) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                print("Task one finished")
                group.leave()
            })
        }
        
        group.enter()
        queue.async(group: group) {
            print("Task two finished")
            group.leave()
        }
        
        group.enter()
        queue.async(group: group) {
            print("Task three finished")
            group.leave()
        }
        
        group.notify(queue: queue) {
            print("All task has finished")
        }
    }
    func test10(){
        //MARK:信号量
        /*
         创建信号量对象，
         调用signal方法发送信号，信号加1，
         调用wait方法等待，信号减1.
         现在也适用信号量实现刚刚的多个请求功能。
         */
        let queue = DispatchQueue.global()
        let group = DispatchGroup()
        let semaphore = DispatchSemaphore(value: 0)
        
        queue.async(group: group) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                semaphore.signal()
                print("Task one finished")
            })
            semaphore.wait()
        }
        queue.async(group: group) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
                semaphore.signal()
                print("Task two finished")
            })
            semaphore.wait()
        }
        queue.async(group: group) {
            print("Task three finished")
        }
        
        group.notify(queue: queue) {
            print("All task has finished")
        }
    }
    
    func test11(){
        //MARK:Suspend / Resume
        /*
         Suspend可以挂起一个线程，即暂停线程，但是仍然暂用资源，只是不执行
         Resume回复线程，即继续执行挂起的线程
         */
    }
    func test12(){
        //MARK:循环执行任务
        /*
         之前使用GCD的dispatch_apply()执行多次任务，现在是调用concurrentPerform(),下面是并发执行5次
         */
        DispatchQueue.concurrentPerform(iterations: 5) {
            print("\($0)")
            //pss_疑 $0?
        }
    }
    func test13(){
        //MARK:DispatchSource
        /*
         DispatchSource提高了相关的API来监控低级别的系统对象，
         比如：Mach ports, Unix descriptors, Unix signals, VFS nodes。
         并且能够异步提交事件到派发列队执行。
         */
    }
    func test14(){
        //MARK:简单定时器
        
        
        // 定时时间
        var timeCount = 60
        // 创建时间源
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer.schedule(deadline: .now(), repeating: .seconds(1))
        timer.setEventHandler {
            timeCount -= 1
            if timeCount <= 0 { timer.cancel() }
            DispatchQueue.main.async {
                print("update UI or other task")
            }
        }
        // 启动时间源
        timer.resume()
    }
    
    func test15() {
        //MARK:执行的过程中取消任务
        let queue = DispatchQueue.global()
        var item: DispatchWorkItem!
        
        // create work item
        item = DispatchWorkItem { [weak self] in
            for i in 0 ... 10_000_000 {
                if item.isCancelled { break }
                print(i)
//                self?.heavyWork()
            }
            item = nil    // resolve strong reference cycle
        }
        
        // start it
        queue.async(execute: item)
        
        // after five seconds, stop it if it hasn't already
        queue.asyncAfter(deadline: .now() + 5) { [weak item] in
            item?.cancel()
        }
    }
    
    func test16(){
        /*
         线程死锁
         不要在主列队中执行同步任务，这样会造成死锁问题。
         */
    }
    
    func test(){
        //MARK: 应用场景
        //1.异步执行回主线程写法
        DispatchQueue.global().async {
            print("async do something\(Thread.current)")
            DispatchQueue.main.async {
                print("come back to main thread\(Thread.current)")
            }
        }
        
        /*
         2.多个任务依次执行
         最容易想到的就是创建一个串行列队，然后添加任务到列队执行。
         */
        let serialQueue = DispatchQueue(label: "com.my.queue")
        serialQueue.async {
            print("task one")
        }
        serialQueue.async {
            print("task two")
        }
        serialQueue.async {
            print("task three")
        }
        /*
         3.其次就是使用前面讲到的DispatchGroup。
         取消DispatchWorkItem的任务
         直接取消任务
         直接调用取消，异步任务不会执行。
         */
        let queue = DispatchQueue(label: "queue", attributes: .concurrent)
        let workItem = DispatchWorkItem {
            print("done")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            queue.async(execute: workItem) // not work
        }
        workItem.cancel()
    }
    
}
