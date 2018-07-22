//
//  WMNetworkResult.swift
//  WMNetwork
//
//  Created by Willima Lee on 14/04/2017.
//  Copyright © 2017 Willima Lee. All rights reserved.
//

import Foundation

internal struct WMNetworkResult {
  
  typealias Action = (_ delegate: WMNetworkDelegate) -> Void

  /// 进度回调
  internal var progressingAction: Action?
  /// 完成回调
  internal var completeAction: Action?
  
  /// 请求结果状态，会包含各种成功、异常信息
  internal var status: WMNetworkStatus = .prepareRequestFailure("未初始化")
  
  /// 请求的响应
  internal var response: HTTPURLResponse?
  
  /// 已上传／下载完成的字节数
  internal var totalCompletedBytes: Int64?
  /// 预计上传／下载的字节数
  internal var totalExpectedBytes: Int64?
  
  /// 已接收的数据
  internal var partialData: Data?
  
  /// 请求获取的数据
  internal var data: Data = Data()
  /// 下载完成后的文件路径
  internal var downloadedFile: URL?
  
}

internal extension WMNetworkResult {
  
  /// 将结果转化为Json字典
  internal var json: [String : Any]? {
    
    guard let temp = try? JSONSerialization.jsonObject(with: self.data, options: .mutableContainers) else { return nil }
    guard let json = temp as? [String : Any] else { return nil }
    
    return json
  }
}












