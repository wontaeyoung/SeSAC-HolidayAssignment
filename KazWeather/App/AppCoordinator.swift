//
//  AppCoordinator.swift
//  KazWeather
//
//  Created by 원태영 on 2/9/24.
//

import UIKit

final class AppCoordinator: Coordinator {
  
  weak var delegate: CoordinatorDelegate?
  var navigationController: UINavigationController
  var childCoordinators: [Coordinator]
  
  init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
    self.childCoordinators = []
  }
  
  func start() {
    showSplashView()
  }
}

extension AppCoordinator {
  
  func showSplashView() {
    let viewController = SplashViewController()
    navigationController.navigationBar.isHidden = true
    
    self.push(viewController, animation: false)
  }
}

extension AppCoordinator: CoordinatorDelegate {
  
  func coordinatorDidEnd(_ childCoordinator: Coordinator) { }
}
