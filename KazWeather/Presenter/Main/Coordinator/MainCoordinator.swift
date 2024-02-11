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
  
  func showMainView(with data: CityWeather) {
    
  }
}
