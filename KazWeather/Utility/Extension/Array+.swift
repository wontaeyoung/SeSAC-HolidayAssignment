//
//  Array+.swift
//  KazWeather
//
//  Created by 원태영 on 2/8/24.
//

extension Array {
  subscript(at index: Int) -> Element? {
    guard self.indices ~= index else { return nil }
    
    return self[index]
  }
}

