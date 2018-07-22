//
//  WMNetworkStatus.swift
//  WMNetwork
//
//  Created by Willima Lee on 06/04/2017.
//  Copyright © 2017 Willima Lee. All rights reserved.
//

import Foundation

/// 请求状态
///
/// - progress: 请求进行中
/// - complete: 请求完成
/// - ok: 请求操作成功，suspend，cancel，resume
/// - prepareRequestFailure: 生成请求失败
/// - requestFailure: 请求失败
/// - responseFailure: 响应失败
/// - system: 系统异常
public enum WMNetworkStatus : Error {
  
  case progress
  case complete
  
  case prepareRequestFailure(String)
  case requestFailure(String)
  case responseFailure(String)
  
  case ok
  
  case system(String)
}

public extension WMNetworkStatus {
  
  public var isNormality: Bool {
    
    switch self {
    case .progress,
         .complete:
      
      return true
      
    default:
      
      return false
    }
    
  }
  
  public var reason: String? {
    
    switch self {
      
    case .prepareRequestFailure(let reason),
         .requestFailure(let reason),
         .responseFailure(let reason),
         .system(let reason):
      
      return reason
      
    default:
      
      return nil
    }
    
  }
  
}
















