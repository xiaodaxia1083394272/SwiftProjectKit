//
//  API.swift
//  Base
//
//  Created by William Lee on 24/03/2018.
//  Copyright © 2018 飞进科技. All rights reserved.
//

import WMNetworkKit
import WMJSONKit


public class API {
  
  /// 是否为开发版
  public static let isDevelop: Bool = false
  
  /// 接口请求方式
  private var method: WMNetwork.HTTPMethod
  /// 接口路径
  private var path: String
  
  private var queryParameters: Any?
  private var bodyParameters: Any?
  
  public init(method: WMNetwork.HTTPMethod, path: String? = nil, version: String? = nil, customPath: String? = nil) {
    
    let base = API.isDevelop ? "http://haha.51feijin.com/api/" : "http://fandomschool.cn/api/"
    
    self.method = method
    if let customPath = customPath {
      
      self.path = customPath
      
    } else {
      
      self.path = base
    }
    
    if let version = version {
      
      self.path += "\(version)/"
    }
    
    if let subpath = path {
      
      self.path += subpath
    }
  }
  
}

// MARK: - General
public extension API {
  
  /// 上传图片
  static var uploadImage = API(method: .post, path: "upload/postedImage")
}

// MARK: - Request
public extension API {
  
  typealias ProgressHandle = (_ progress: Float) -> Void
  typealias CompleteHandle = (_ result: WMJSON) -> Void
  
  /// 设置查询参数
  func query(_ parameters: Any) -> Self {
    
    self.queryParameters = parameters
    return self
  }
  
  /// 设置请求题参数
  func body(_ parameters: Any) -> Self {
    
    self.bodyParameters = parameters
    return self
  }
  
  /// 进行请求
  func request(isIngnoreLogin: Bool = false, handle: @escaping CompleteHandle) {
    
    let api = self
    WMNetwork.isDebug = true
    var network = WMNetwork.request(api.method, api.path, isDebug: true)
    if let query = api.queryParameters { network = network.query(query) }
    if let body = api.bodyParameters { network = network.body(body) }
    network.data({ (data, status) in
      
      guard let data = data else { return }
      var json = WMJSON()
      json.update(from: data)
      
      // 调试
      self.debugLog(json)
      DispatchQueue.main.async(execute: {
        
        handle(json)
        
        // 处理未登录
        //guard json["result"] ?? 0 == -2 && isIngnoreLogin == false else { return }

      })
      
    })
    
  }
  
}

// MARK: - Utility
private extension API {
  
  func debugLog(_ json: WMJSON) {
    
    let api = self
    #if DEBUG
      print(api.path)
      if let query = api.queryParameters { print(query) }
      if let body = api.bodyParameters { print(body) }
      print(json)
    #endif
  }
  
}

