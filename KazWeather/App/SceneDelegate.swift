//
//  SceneDelegate.swift
//  KazWeather
//
//  Created by 원태영 on 2/8/24.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  var coordinator: AppCoordinator?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(windowScene: scene)
    
    let rootViewController = UINavigationController()
    self.coordinator = AppCoordinator(rootViewController)
    window?.rootViewController = rootViewController
    window?.makeKeyAndVisible()
    
    coordinator?.start()
  }
}
