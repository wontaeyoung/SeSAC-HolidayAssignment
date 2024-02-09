//
//  HTTPParameter.swift
//  KazWeather
//
//  Created by 원태영 on 2/8/24.
//

import Foundation

struct HTTPParameter {
  
  let key: String
  let value: String
  
  var queryItem: URLQueryItem {
    return URLQueryItem(name: key, value: value)
  }
}

struct HTTPParameters {
  
  // MARK: - Property
  var current: [URLQueryItem] {
    return self.parameters.map { $0.queryItem }
  }
  
  private var parameters: [HTTPParameter]
  
  // MARK: - Initializer
  init() {
    self.parameters = []
  }
  
  init(_ parameter: HTTPParameter) {
    self.parameters = [parameter]
  }
  
  init(_ parameterList: [HTTPParameter]) {
    self.parameters = parameterList
  }
  
  init(_ parameterDictionary: [String: String]) {
    self.parameters = parameterDictionary.map { HTTPParameter(key: $0.key, value: $0.value) }
  }
  
  
  // MARK: - Method
  mutating func update(_ parameter: HTTPParameter) {
    guard let index = parameters.index(of: parameter.key) else {
      self.add(parameter)
      return
    }
    
    self.parameters[index] = parameter
  }
  
  mutating func update(key: String, value: String) {
    update(HTTPParameter(key: key, value: value))
  }
  
  mutating func remove(key: String) {
    guard let index = parameters.index(of: key) else { return }
    
    self.parameters.remove(at: index)
  }
  
  mutating private func add(_ parameter: HTTPParameter) {
    self.parameters.append(parameter)
  }
}

// MARK: - Funtional Stream
extension HTTPParameters {
  func parameter(_ parameter: HTTPParameter) -> Self {
    return self.parameterAdded(parameter)
  }
  
  func parameter(key: String, value: String) -> Self {
    return self.parameterAdded(HTTPParameter(key: key, value: value))
  }
  
  private func parameterAdded(_ parameter: HTTPParameter) -> Self {
    var parameters = self
    parameters.update(parameter)
    
    return parameters
  }
}

extension Array where Element == HTTPParameter {
  func index(of key: String) -> Int? {
    return firstIndex { $0.key.lowercased() == key.lowercased() }
  }
}
