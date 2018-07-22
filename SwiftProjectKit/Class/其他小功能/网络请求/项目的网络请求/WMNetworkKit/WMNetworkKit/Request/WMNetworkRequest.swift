//
//  WMNetworkRequest.swift
//  WMNetwork
//
//  Created by Willima Lee on 14/04/2017.
//  Copyright © 2017 Willima Lee. All rights reserved.
//

import Foundation

internal struct WMNetworkRequest {
  
  /// 请求地址
  var urlString: String?
  
  /// 查询参数
  var queryParameters: Any?
  
  /// 请求体参数
  var bodyParameters: Any?
  
  /// Form表单数据
  var formData: Data?
  
  /// 请求方式
  var httpMethod: String = "GET"
  
  /// 内容类型
  var contentType: String = "application/json; charset=utf-8"
  
  /// 保存请求
  var urlRequest: URLRequest?
}

internal extension WMNetworkRequest {
  
  /// 准备请求
  ///
  /// - Returns: 生成的请求
  /// - Throws: WMNetworkStatus.requestFailureReason，包含生成请求失败的原因
  mutating func prepare() -> WMNetworkStatus {
    
    // 1、获取请求地址
    guard let urlString = self.urlString else {
      
      return WMNetworkStatus.prepareRequestFailure("Reason：请求地址为空")
    }
    
    // 2、请求地址
    var urlStringWithQuery = urlString
    
    // 3、生成Query，并附加到请求地址后
    if let query = self.queryParameters as? [String: Any] {
      
      urlStringWithQuery.append("?")
      urlStringWithQuery.append(query.map { "\($0)=\($1)" }.joined(separator: "&"))
      
    }
    
    // 4、对请求地址进行编码
    guard let urlStringWithQueryAndEncod = urlStringWithQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
      
      return WMNetworkStatus.prepareRequestFailure("Reason：对请求地址及请求头编码失败：\nURLString:\(urlStringWithQuery)")
    }
    
    // 5、根据编码后的请求地址生成URL
    guard let url = URL(string: urlStringWithQueryAndEncod) else {
      
      return WMNetworkStatus.prepareRequestFailure("Reason：无法生成URL:\(urlStringWithQueryAndEncod)")
    }
    
    // 6、生成URLRequest
    var request = URLRequest(url: url)
    
    // 7、配置请求方式
    request.httpMethod = self.httpMethod
    
    // 8、配置请求域
    request.setValue(self.contentType, forHTTPHeaderField: "content-type")
    
    // 9、配置请求体
    if self.httpMethod != "GET", let body = bodyParameters {
      
      if let formData = self.formData {
        
        request.httpBody = formData
        
      } else {
        
        guard let temp = try? JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted) else {
          
          return WMNetworkStatus.prepareRequestFailure("Reason：请求体参数转化成Json Data失败：\nBody:\(body)")
        }
        request.httpBody = temp
      }
      
    }
    
    self.urlRequest = request
    
    return .ok
  }
  
}



