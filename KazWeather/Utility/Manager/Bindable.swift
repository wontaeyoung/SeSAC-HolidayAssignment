//
//  Bindable.swift
//  KazWeather
//
//  Created by 원태영 on 2/9/24.
//

final class Bindable<T> {
  
  typealias Completion = (T) -> Void
  typealias Action = (thread: Thread, completion: Completion)
  
  enum Thread {
    case main
    case global
  }
  
  // MARK: - Property
  private var value: T {
    didSet {
      guard let action else { return }
      
      switch action.thread {
        case .main:
          GCD.main { [weak self] in
            guard let self else { return }
            
            action.completion(value)
          }
          
        case .global:
          GCD.global { [weak self] in
            guard let self else { return }
            
            action.completion(value)
          }
      }
    }
  }
  
  var current: T {
    return self.value
  }
  
  var action: Action?
  
  
  // MARK: - Initializer
  init(value: T) {
    self.value = value
  }
  
  
  // MARK: - Method
  func set(_ value: T) {
    self.value = value
  }
  
  func subscribe(thread: Thread, completion: @escaping Completion) {
    completion(value)
    self.action = (thread, completion)
  }
}

extension Bindable: ExpressibleByIntegerLiteral where T == Int {
  convenience init(integerLiteral value: Int) {
    self.init(value: value)
  }
}

extension Bindable: ExpressibleByFloatLiteral where T == Double {
  convenience init(floatLiteral value: Double) {
    self.init(value: value)
  }
}

extension Bindable: ExpressibleByBooleanLiteral where T == Bool {
  convenience init(booleanLiteral value: Bool) {
    self.init(value: value)
  }
}

extension Bindable: ExpressibleByStringLiteral where T == String {
  convenience init(stringLiteral value: String) {
    self.init(value: value)
  }
}


extension Bindable: ExpressibleByUnicodeScalarLiteral where T == String {
  convenience init(unicodeScalarLiteral value: String) {
    self.init(value: value)
  }
}

extension Bindable: ExpressibleByExtendedGraphemeClusterLiteral where T == String {
  convenience init(extendedGraphemeClusterLiteral value: String) {
    self.init(value: value)
  }
}
