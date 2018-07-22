//
//  WMNetwork+DownloadTask.swift
//  WMNetwork
//
//  Created by William Lee on 18/4/17.
//  Copyright © 2018年 Willima Lee. All rights reserved.
//

import Foundation

public extension WMNetwork {
  
  typealias DownloadCompleteAction = (_ tempLocation: URL?, _ status: WMNetworkStatus) -> Void
  
  /// 处理下载的数据
  ///
  /// - Parameters:
  ///   - resumeData: 包含继续下载所需信息，若不提供，则重新下载
  ///   - action: 下载完成或出现异常后进行回调，处理下载文件的临时地址及错误信息
  public func download(with resumeData: Data? = nil, _ action: @escaping DownloadCompleteAction) {
    
    //设置内部完成回调
    resultComplete { (delegate) in
      
      //执行外部设置的完成回调
      action(delegate.result.downloadedFile, delegate.result.status)
    }
    
    //设置代理类型
    self.delegate.taskType = .downloadTask
    
    //若有ResumeData，创建DownloadTask继续下载，
    if let resumeData = resumeData {
      
      setupTask({ (session, urlRequest) -> URLSessionTask? in
        
        let task = session.downloadTask(withResumeData: resumeData)
        
        //使用ResumeData创建的下载任务，请求在currentRequest中，originalRequest为空
        //防止意外，若为空，则立刻取消此任务
        guard let urlRequest = self.delegate.task?.currentRequest else {
          
          self.delegate.task?.cancel()
          return nil
        }
        
        //保存请求
        self.delegate.request.urlRequest = urlRequest
        
        return task
      })

    } else {
      
      setupTask { (session, urlRequest) -> URLSessionTask? in
        
        guard let urlRequest = urlRequest else { return nil }
        return session.downloadTask(with: urlRequest)
      }
      
    }
    
        
  }
  
  
  typealias DownloadCancelHandle = (_ resumeData: Data?, _ status: WMNetworkStatus) -> Void
  
  /// 取消下载
  ///
  /// - Parameter action: 处理暂停下载的内容
  public func cancelDownload(_ handle: @escaping DownloadCancelHandle) {
    
    handleTask { (task) in
      
      var resumeData: Data? = nil
      defer {
        
        handle(resumeData, self.delegate.result.status)
      }
      
      guard let task = task else { return }
      
      //取消下载任务，同时处理ResumeData
      (task as? URLSessionDownloadTask)?.cancel(byProducingResumeData: { (temp) in
        
        resumeData = temp
        
        //保证从代理池中移除
        guard let urlRequest = self.delegate.request.urlRequest else {
          
          self.delegate.result.status = .requestFailure("Reason：无法获取任务对应的URLRequest,无法将代理从代理池中去除")
          return
        }
        WMNetwork.delegatePool.removeValue(forKey: urlRequest)
        
        self.delegate.result.status =  .ok
      })
      
    }
    


    
  }
  
}
