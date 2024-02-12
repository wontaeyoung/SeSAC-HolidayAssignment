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
    navigationController.setNavigationBarHidden(true, animated: false)
    showSplashView()
  }
}

/// Splash와 Main Coordinator 플로우를 분리하려고 했는데 문제가 발생함
/// Splash에서 요청한 네트워크 결과 Splash Flow를 종료하면서 Main Flow에 전달해야 하는데, DidEnd로는 데이터를 파라미터에 받아줄 수 없다.
/// DidEnd 함수를 수정하면 프로토콜 인터페이스 정의를 건드려야되서 모든 Coordinator가 영향을 받는다.
/// 전역으로 접근 가능한 곳에 데이터를 저장하면 가능할 것 같은데, 로직을 수행하기 위해 너무 고민없는 방법을 선택하는 것 같음...
/// 우선은 SplashView를 AppCoordinator에서 show 하고, 네트워크 응답이 오면 splashView에서 connectMain을 호출하면서 전달하는 방식으로 해결
extension AppCoordinator {
  
  func showSplashView() {
    let viewModel = SplashViewModel()
    let viewController = SplashViewController(viewModel: viewModel)
    
    self.push(viewController, animation: false)
  }
  
  /// Coordinator가 시작할 때, 파라미터에서 데이터를 받아줘야하는 케이스가 오면 문제가 발생함
  /// 새로운 Coordinator는 start 함수로 시작하도록 일관성을 유지하고 있었는데
  /// start는 파라미터를 받지 않는 메서드로 되어있어서 데이터를 전달받을 수 없음
  /// start 대신 showing 함수를 직접 호출하거나
  /// start를 호출 일관성을 유지하기 위해 데이터를 별도의 방법으로 Coordinator에 주입해야하는데
  /// Coordinator가 데이터를 가지게 될 뿐더러, Coordinator initializer도 별도의 데이터를 받을 수 없도록 protocol에 정의되어 있음
  /// 그래서 우회해서 데이터를 주입해야 하는데, 놓쳤을 때 컴파일 에러를 띄워주지도 않는 방식이라 위험성이 높음
  func connectMainFlow(currentWeather: CityWeather, forecastBy3H: [CityWeather]) {
    let coordinator = MainCoordinator(self.navigationController)
    self.addChild(coordinator)
    coordinator.delegate = self
    
    coordinator.showMainView(currentWeather: currentWeather, forecastBy3H: forecastBy3H)
  }
}

extension AppCoordinator: CoordinatorDelegate {
  
  func coordinatorDidEnd(_ childCoordinator: Coordinator) { }
}
