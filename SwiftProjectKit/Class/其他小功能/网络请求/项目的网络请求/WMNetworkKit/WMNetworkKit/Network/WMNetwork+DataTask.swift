//
//  WMNetwork+DataTask.swift
//  WMNetwork
//
//  Created by William Lee on 18/4/17.
//  Copyright © 2018年 Willima Lee. All rights reserved.
//

import Foundation

public extension WMNetwork {
  
  typealias DataCompleteAction = (_ data: Data?, _ status: WMNetworkStatus) -> Void
  
  /// 处理Data数据
  ///
  /// - Parameter action: 获取Data数据或出现异常后进行回调，处理Data数据集错误信息
  public func data(_ action: @escaping DataCompleteAction) {
    
    //外部完成回调打包成内部完成回调
    self.resultComplete({ (delegate) in
      
      //组装参数提供给外部回调
      action(delegate.result.data, delegate.result.status)
    })
    
    //设置代理类型
    self.delegate.taskType = .dataTask
    
    //启动任务
    self.setupTask({ (session, request) -> URLSessionTask? in
      
      guard let urlRequest = request else { return nil }
      return session.dataTask(with: urlRequest)
    })
    
  }
  
  
}
