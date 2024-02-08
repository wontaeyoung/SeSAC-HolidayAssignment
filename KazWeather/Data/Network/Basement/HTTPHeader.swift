//
//  HTTPHeader.swift
//  KazWeather
//
//  Created by 원태영 on 2/8/24.
//

import Foundation

struct HTTPHeader {
  
  let key: String
  let value: String
}

struct HTTPHeaders {
  
  typealias HeaderFields = [String: String]
  
  // MARK: - Property
  var current: HeaderFields {
    var combined = HeaderFields()
    
    self.headers.forEach {
      combined.updateValue($0.value, forKey: $0.key)
    }
    
    return combined
  }
  
  private var headers: [HTTPHeader]
  
  // MARK: - Initializer
  init() {
    self.headers = []
  }
  
  init(_ headerList: [HTTPHeader]) {
    self.headers = headerList
  }
  
  init(_ headerDictionary: [String: String]) {
    self.headers = headerDictionary.map { HTTPHeader(key: $0.key, value: $0.value) }
  }
  
  
  // MARK: - Method
  mutating func update(_ header: HTTPHeader) {
    guard let index = headers.index(of: header.key) else {
      return self.add(header)
    }
    
    self.headers[index] = header
  }
  
  mutating func update(key: String, value: String) {
    update(HTTPHeader(key: key, value: value))
  }
  
  mutating func remove(key: String) {
    guard let index = headers.index(of: key) else { return }
    
    self.headers.remove(at: index)
  }
  
  mutating private func add(_ header: HTTPHeader) {
    self.headers.append(header)
  }
}

extension HTTPHeaders {
  mutating func header(_ header: HTTPHeader) -> Self {
    update(header)
    
    return self
  }
  
  mutating func header(key: String, value: String) -> Self {
    update(HTTPHeader(key: key, value: value))
    
    return self
  }
}

extension Array where Element == HTTPHeader {
  func index(of key: String) -> Int? {
    return firstIndex { $0.key.lowercased() == key.lowercased() }
  }
}
