//
//  WMNetworkDelegate.swift
//  WMNetwork
//
//  Created by Willima Lee on 06/04/2017.
//  Copyright © 2017 Willima Lee. All rights reserved.
//

import Foundation

internal class WMNetworkDelegate : NSObject {
  
  /// 是否为Debug模式，然后和请求的Debug参数共同决定是否打印相关日志
  internal var isDebug: Bool = false
  
  internal var taskType: WMNetworkDelegate.TaskType?
  
  internal weak var task: URLSessionTask?
  
  internal var request: WMNetworkRequest = WMNetworkRequest()
  internal var result: WMNetworkResult = WMNetworkResult()
  
  deinit {
    
    self.delegateLog("Delegate is Dead")
  }
  
}

internal extension WMNetworkDelegate {
  
  enum TaskType {
    
    case dataTask
    case downloadTask
    case uploadTask
  }
}

// MARK: - Action
internal extension WMNetworkDelegate {
  
  /// 打印
  ///
  /// - Parameters:
  ///   - message: 消息
  ///   - file: 调用时，所在文件路径
  ///   - line: 调用时，所在行
  ///   - functionName: 调用时，所在函数
  func delegateLog(message: String? = nil, _ file: String = #file, _ line: Int = #line, _ functionName: String = #function) {
    
    guard WMNetwork.isDebug && self.isDebug else { return }
    let fileName = file.components(separatedBy: "/").last ?? ""
    print("File:\(fileName)  Line:\(line)  Function:\(functionName)")
    guard let message = message else { return }
    print("Message:\(message)")
  }
  
}






























