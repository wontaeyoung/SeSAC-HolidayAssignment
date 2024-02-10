//
//  ViewModelController.swift
//  KazWeather
//
//  Created by 원태영 on 2/11/24.
//

protocol ViewModelController {
  associatedtype ViewModelType = ViewModel
  
  var viewModel: ViewModelType { get }
}
