//
//  WMReachability.swift
//  WMNetworkKit
//
//  Created by Willima Lee on 2017/9/9.
//  Copyright © 2018年 William Lee. All rights reserved.
//

import Foundation
import SystemConfiguration

/// 网络状态变更后，通知中UserInfo中用此Key获取网络状态, value为WMReachability.Status类型
public let WMNetworkReachabilityStatusKey: String = "WMNetworkReachabilityStatusKey"

// MARK: - 网络状态变更后的发出通知
public extension Notification.Name {
  
  static let networkReachabilityChanged: Notification.Name = Notification.Name("WMNetworkReachabilityChangedNotification")
  
}

public class WMReachability: NSObject {
  
  /// 网络状态
  ///
  /// - not: 无网络连接
  /// - wifi: WiFi网络
  /// - wwan: 蜂窝网络
  public enum Status {
    
    case not
    case wifi
    case wwan
    
  }
  
  
  private var reachability: SCNetworkReachability
  
  private var status: Status = .not
  
  public var queue: DispatchQueue = DispatchQueue.main
  public var monitorHandle: (_ status: Status) -> Void = { status in
    
    switch status {
      
    case .wifi:
      
      if WMNetwork.isDebug {
        
        print("WiFi")
      }
      
    case .wwan:
      
      if WMNetwork.isDebug {
        
        print("WWAN")
      }
      
    default:
      
      if WMNetwork.isDebug {
        
        print("No Network")
      }
      
      break
    }
  }
  
  
  public init?(host: String) {
    
    guard let reachability = SCNetworkReachabilityCreateWithName(nil, host) else {
      
      return nil
    }
    self.reachability = reachability
    
    super.init()
  }
  
  deinit {
    
    stopMonitor()
  }
  
  static let callback: SystemConfiguration.SCNetworkReachabilityCallBack = { target, flags, info in
    
    let reachability = Unmanaged<WMReachability>.fromOpaque(info!).takeUnretainedValue()
    
    //执行监听回调
    let status = reachability.query(flags)
    
    guard reachability.status != status else { return }
    
    reachability.status = status
    reachability.monitorHandle(status)
    
    NotificationCenter.default.post(name: .networkReachabilityChanged, object: nil, userInfo: [WMNetworkReachabilityStatusKey : reachability.status])
  }
  
  
  /// 启动网络监控
  ///
  /// - Returns: 是否成功启动
  @discardableResult
  public func startMonitor() -> Bool {
    
    var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
    context.info = Unmanaged.passUnretained(self).toOpaque()
    
    let canCallBack = SCNetworkReachabilitySetCallback(reachability, WMReachability.callback, &context)
    let canDispatch = SCNetworkReachabilitySetDispatchQueue(reachability, queue)
    
    return canCallBack && canDispatch
    
  }
  
  
  /// 停止网络监控
  public func stopMonitor() {
    
    SCNetworkReachabilitySetCallback(self.reachability, nil, nil)
    SCNetworkReachabilitySetDispatchQueue(self.reachability, nil)
    
  }
  
}

extension WMReachability {
  
  /// 获取网络状态
  ///
  /// - Parameter flags: 网络标记
  /// - Returns: 网络状态
  private func query(_ flags: SCNetworkReachabilityFlags) -> Status {
    
    guard flags.contains(.reachable) else { return .not }
    
    var networkStatus: Status = .not
    
    if !flags.contains(.connectionRequired) {
      
      networkStatus = .wifi
    }
    
    if flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic) {
      
      if !flags.contains(.interventionRequired) {
        
        networkStatus = .wifi
      }
    }
    
    #if os(iOS)
      if flags.contains(.isWWAN) {
        
        networkStatus = .wwan
      }
    #endif
    
    return networkStatus
  }
  
}







