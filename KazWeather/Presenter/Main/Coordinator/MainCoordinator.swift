//
//  MainCoordinator.swift
//  KazWeather
//
//  Created by 원태영 on 2/11/24.
//

import UIKit

final class MainCoordinator: Coordinator {
  
  weak var delegate: CoordinatorDelegate?
  var navigationController: UINavigationController
  var childCoordinators: [Coordinator]
  
  init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
    self.childCoordinators = []
  }
  
  func start() {
    
  }
}

extension MainCoordinator {
  
  func showMainView(currentWeather: CityWeather, forecastBy3H: [CityWeather]) {
    let viewModel = MainViewModel(coordinator: self, cityWeather: currentWeather, forecastBy3H: forecastBy3H)
    let viewController = MainViewController(viewModel: viewModel)
    
    self.push(viewController)
  }
}
