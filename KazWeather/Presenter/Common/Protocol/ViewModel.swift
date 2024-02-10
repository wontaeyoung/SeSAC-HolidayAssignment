//
//  ViewModel.swift
//  KazWeather
//
//  Created by 원태영 on 2/9/24.
//

protocol ViewModel {
  associatedtype CoordinatorType: Coordinator
  
  var coordinator: CoordinatorType? { get set }
}
