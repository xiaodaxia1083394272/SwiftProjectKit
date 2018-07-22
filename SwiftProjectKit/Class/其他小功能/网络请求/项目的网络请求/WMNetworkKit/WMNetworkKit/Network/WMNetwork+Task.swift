//
//  WMNetwork+Task.swift
//  WMNetwork
//
//  Created by William Lee on 18/4/17.
//  Copyright © 2018年 Willima Lee. All rights reserved.
//

import Foundation

// MARK: - Generalhandle
public extension WMNetwork {
  
  typealias StatusHandle = (_ status: WMNetworkStatus) -> Void
  
  /// 暂停任务
  public func suspend(_ handle: StatusHandle) {
    
    handleTask { (task) in
      
      defer {
        
        handle(self.delegate.result.status)
      }
      
      guard let task = task else { return }
      
      task.suspend()
      
      self.delegate.result.status = .ok
      
    }
    
  }
  
  public func resume(_ handle: StatusHandle) {
    
    handleTask { (task) in
      
      defer {
        
        handle(self.delegate.result.status)
      }
      
      guard let task = task else { return }
      
      task.resume()
      
      self.delegate.result.status = .ok
      
    }
  
  }
  
  /// 取消任务，任务将不可恢复，若想取消下载任务后，能继续下载，使用cancelDownload，获取resumeData，用于继续下载
  public func cancel(_ handle: StatusHandle) {
    
    handleTask { (task) in
      
      defer {
        
        handle(self.delegate.result.status)
      }
      
      //guard let task = task else { return }
      
      task?.cancel()
      
      //保证从代理池中移除
      guard let urlRequest = self.delegate.request.urlRequest else {
        
        self.delegate.result.status = .requestFailure("Reason：无法获取任务对应的URLRequest")
        return
      }
      WMNetwork.delegatePool.removeValue(forKey: urlRequest)
      self.delegate.result.status = .ok
    }
    

  }
  
}

internal extension WMNetwork {
  
  /// 创建并启动任务
  ///
  /// - Parameter action: 用于指明创建什么任务
  func setupTask(_ action: (_ session: URLSession, _ urlRequest: URLRequest?) -> URLSessionTask?) {
    
    //创建回话
    let session = URLSession(configuration: WMNetwork.configuration,
                             delegate: self.delegate,
                             delegateQueue: self.delegateQueue)
    
    //获取请求
    self.delegate.result.status = delegate.request.prepare()
    
    //无需在失败的时候设置错误状态，已经在上一步的prepare()进行了处理
    guard let urlRequest = self.delegate.request.urlRequest else { return }
    
    //创建任务
    guard let task = action(session, urlRequest) else {
    
      self.delegate.result.status = .requestFailure("Reason:创建URLSessionTask失败")
      return
    }
    
    //保存任务
    self.delegate.task = task
    
    //将代理加入代理池，后续会对任务的精细化操作
    WMNetwork.delegatePool[urlRequest] = self.delegate
    //启动任务
    self.delegate.task?.resume()
    
  }
  
  /// 依赖内容相同URLRequest，获取代理池中的代理，进行操作
  ///
  /// - Parameter action: 指明如何操作任务
  func handleTask(_ handle: (URLSessionTask?) -> Void) {
    
    var task: URLSessionTask?
    
    defer {
      
      handle(task)
    }
    
    //获取请求
    self.delegate.result.status = self.delegate.request.prepare()
    //无需在失败的时候设置错误状态，已经在上一步的prepare()进行了处理
    guard let urlRequest = self.delegate.request.urlRequest else { return }
    
    //根据URLRequest获取一个存在的Delegate，继而获取对应任务
    guard let delegate = findDelegate(urlRequest) else {
      
      self.delegate.result.status = WMNetworkStatus.requestFailure("Reason:内部未通过\(urlRequest)找到Delegate")
      return
    }
    
    //判断delegate的task是否存在，不存在则保存异常状态
    if let temp = delegate.task {
      
      task = temp
      
    } else {
      
      self.delegate.result.status = WMNetworkStatus.requestFailure("Reason:内部未找到Task")
      
    }
    
  }
  
  /// 根据给的URLRequest在DelegatePool中查找Delegate.
  /// 不知为何，相同内容的URLRequest，比较却不相同，无法取出值，此处使用hashValue
  ///
  /// - Parameter urlRequest: 查找条件
  /// - Returns: 结果
  func findDelegate(_ urlRequest: URLRequest) -> WMNetworkDelegate? {
    
    for (temp, delegate) in WMNetwork.delegatePool {
      
      if temp.hashValue == urlRequest.hashValue {
        
        return delegate
      }
      
      
    }
    
    return nil
  }
  
}












