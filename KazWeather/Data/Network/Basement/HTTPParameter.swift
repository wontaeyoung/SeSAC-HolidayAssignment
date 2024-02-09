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

/**
 구조체는 불변성으로 인해 자기 자신에 새 인스턴스를 할당할 수 없다.
 
 Self를 리턴하면서 스트림 방식으로 사용하고 싶어도, 원본을 변경하고 반환하는 스트림 방식은 사용이 불가하다.
 
 인스턴스를 가변인 변수에 담아두면 변경이 된 self를 반환할 수 있지만, 첫 반환 이후에는 불변성으로 다시 체이닝을 하는 것이 불가하고, 리턴된 그 self도 원본의 복사본에 해당한다.
 
 구조체에서 스트림 방식으로 함수를 사용하고 싶다면, 원본을 유지하고 새로운 인스턴스에 변경을 적용한 다음 반환하는 방식으로 구현해야한다.
 */
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
