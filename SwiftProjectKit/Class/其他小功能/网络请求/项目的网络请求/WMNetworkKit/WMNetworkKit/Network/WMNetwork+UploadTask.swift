//
//  WMNetwork+UploadTask.swift
//  WMNetwork
//
//  Created by William Lee on 18/4/17.
//  Copyright © 2018年 Willima Lee. All rights reserved.
//

import Foundation

public extension WMNetwork {
  
  typealias UploadCompleteAction = (_ data: Data?, _ status: WMNetworkStatus) -> Void
  
  /// 上传文件内容
  ///
  /// - Parameters:
  ///   - file: 文件地址
  ///   - action: 上传完成或出现异常后进行回调，处理上传完成后服务器返回信息及错误信息
  public func upload(with file: URL, _ action: @escaping UploadCompleteAction) {
    
    //设置内部完成回调
    resultComplete { (delegate) in
      
      //执行外部设置的完成回调
      action(delegate.result.data, delegate.result.status)
    }
    
    setupTask { (session, urlRequest) -> URLSessionTask? in
      
      guard let urlRequest = urlRequest else { return nil }
      return session.uploadTask(with: urlRequest, fromFile: file)
    }
    
  }
  
  /// 上传数据
  ///
  /// - Parameters:
  ///   - data: 上传的数据，可以认为是httpBody
  ///   - action: 上传完成或出现异常后进行回调，处理上传完成后服务器返回信息及错误信息
  public func upload(with data: Data, _ action: @escaping UploadCompleteAction) {
    
    //设置内部完成回调
    resultComplete { (delegate) in
      
      //执行外部设置的完成回调
      action(delegate.result.data, delegate.result.status)
    }
    
    setupTask { (session, urlRequest) -> URLSessionTask? in
      
      guard let urlRequest = urlRequest else { return nil }
      return session.uploadTask(with: urlRequest, from: data)
    }
  }
  
}
