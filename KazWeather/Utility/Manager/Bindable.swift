//
//  Bindable.swift
//  KazWeather
//
//  Created by 원태영 on 2/9/24.
//

final class Bindable<T> {
  
  enum Thread {
    case main
    case global
  }
  
  // MARK: - Property
  var value: T {
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
  
  var action: (thread: Thread, completion: (T) -> Void)?
  
  
  // MARK: - Initializer
  init(value: T) {
    self.value = value
  }
  
  
  // MARK: - Method
  func subscribe(thread: Thread, completion: @escaping (T) -> Void) {
    completion(value)
    self.action = (thread, completion)
  }
}
