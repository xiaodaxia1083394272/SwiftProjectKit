//
//  WMJSON.swift
//  WMJSONKit
//
//  Created by William Lee on 9/10/17.
//  Copyright © 2018年 William Lee. All rights reserved.
//

import Foundation

public struct WMJSON {
  
  /// 表示JSON解析过程中的消息
  var messages: [String] = []
  
  /// JSON原始
  private var data: Any?
  
  /// 用于内部取值
  private var dictionary: [String : Any]?
  /// 用于内部取值
  private var array: [Any]?
  
  /// 根据JSON(字典、数组)数据创建WMJSON对象
  ///
  /// - Parameter jsonData: JSON数据
  public init(_ source: Any? = nil) {
    
    self.messages.append("JSON is init!")
    self.update(from: source)
  }

}

// MARK: - Type Value
public extension WMJSON {
  
  var int: Int? {
    
    if let temp = self.data as? String {
      
      return Int(temp)
    }
    
    return self.value()
  }
  
  var double: Double? {
    
    if let temp = self.data as? String {
      
      return Double(temp)
    }
    
    return self.value()
  }
  
  var float: Float? {
    
    if let temp = self.data as? String {
      
      return Float(temp)
    }
    
    return self.value()
  }
  
  func value<T>() -> T? {
    
    return self.data as? T
  }
  
}

// MARK: - JSON Save
public extension WMJSON {
  
  /// 保存JSON到指定URL
  ///
  /// - Parameter url: url
  /// - Returns: false: 保存失败，true：保存成功
  @discardableResult
  func save(to url: URL) -> Bool {
    
    guard let objcet = self.data else { return false }
    
    do {
      
      let data = try JSONSerialization.data(withJSONObject: objcet, options: .prettyPrinted)
      
      if FileManager.default.fileExists(atPath: url.absoluteString) {
        
        try FileManager.default.removeItem(at: url)
      }
      
      try data.write(to: url)
      
      return true
      
    } catch {
      
      return false
    }
    
  }
  
}

// MARK: - Update From Source
public extension WMJSON {
  
  /// 接收URL/Data/JSONObject进行更新JSON数据
  ///
  /// - Parameter source: URL/Data/JSONO对象
  mutating func update(from source: Any?) {
    
    self.messages.append("Update from Source Successfully")
    guard let source = source else {
    
      self.messages.append("Source is Empty")
      return
    }
    
    if let url = source as? URL {
      
      self.update(from: url)
      return
    }
    
    if let data = source as? Data {
      
      self.update(from: data)
      return
    }
    
    if let dictionary = source as? [String : Any] {
      
      self.update(from: dictionary)
      return
    }
    
    if let array = source as? [Any] {
      
      self.update(from: array)
      return
    }
    
    self.messages.append("Source isn't URL, Data, [String: Any] and [Any]")
  }
  
  /// 从指定URL地址获取JSON数据
  ///
  /// - Parameter url: 获取JSON数据的URL
  mutating func update(from url: URL) {
    
    guard let data = try? Data(contentsOf: url) else {
    
      self.messages.append("Fetch json data failed from URL: \(url)")
      return
    }
    self.update(from: data)
  }
  
  /// 使用JSON数据更新
  ///
  /// - Parameter jsonData: JSON数据：[Any]、[String: Any]
  mutating func update(from jsonData: Data) {
    
    do {
      
      let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
      
      if let dictionary = jsonObject as? [String : Any] {
        
        self.update(from: dictionary)
        return
      }
      
      if let array = jsonObject as? [Any] {
        
        self.update(from: array)
        return
      }
      
    } catch {
      
      self.messages.append("Json Serialization failed reason: \(error.localizedDescription)")
    }
  }
  
  /// 使用JSON字典进行数据更新
  ///
  /// - Parameter dictionary: JSON字典
  mutating func update(from dictionary: [String: Any]) {
    
    self.data = dictionary
    self.dictionary = dictionary
    self.messages.append("Update Json from dictionary successfully")
  }
  
  /// 使用JSON数组进行数据更新
  ///
  /// - Parameter array: JSON数组
  mutating func update(from array: [Any]) {
    
    self.data = array
    self.array = array
    self.messages.append("Update Json from array successfully")
  }
  
}

// MARK: - Subscript
public extension WMJSON {
  
  /// 根据键值获取字典
  ///
  /// - Parameter key: 获取值的Key
  subscript<T>(_ key: String) -> T? {
    
    return self.dictionary?[key] as? T
  }
  
  /// 根据键值获取子JSON，用于多级取值
  ///
  /// - Parameter key: 子JSON的键值
  subscript(_ key: String) -> WMJSON {
    
    return WMJSON(self.dictionary?[key])
  }
  
  /// 根据索引获取子JSON，用于多级取值
  ///
  /// - Parameter index: 子JSON的索引
  subscript(_ index: Int) -> WMJSON {
    
    var json = WMJSON()
    
    guard index < self.array?.count ?? 0 else {
      
      json.messages.append("Index out of range")
      return json
    }
    json.update(from: self.array?[index])
    return json
  }
  
}

// MARK: - Higher-Order Function
public extension WMJSON {
  
  /// JSON数组进行映射
  func map<T>(_ transform: (WMJSON) -> T) -> [T] {
    
    return self.array?.map({ WMJSON($0) }).map({ transform($0) }) ?? []
  }
  
  /// JSON数组进行遍历
  func forEach(_ body: (WMJSON) -> Void) {
    
    self.array?.map({ WMJSON($0) }).forEach({ body($0) })
  }
  
}

// MARK: - CustomStringConvertible
extension WMJSON: CustomStringConvertible {
  
  public var description: String {
    
    return self.prettyDescription()
  }
  
}

// MARK: - CustomDebugStringConvertible
extension WMJSON: CustomDebugStringConvertible {
  
  public var debugDescription: String {
    
    return self.prettyDescription()
  }
  
  
}

// MARK: - PrettyJSONDescription
private extension WMJSON {
  
  func prettyDescription() -> String {
   
    var jsonObject: Any
    if let object = self.dictionary { jsonObject = object }
    else if let object = self.array { jsonObject = object }
    else { return "ERROR: Empty" }
    
    guard let descriptionData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else { return "ERROR: JSONSerialization FAILED" }
    return String(data: descriptionData, encoding: .utf8) ?? "ERROR: ENCODING FAILED"
  }
  
}




