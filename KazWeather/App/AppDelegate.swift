//
//  AppDelegate.swift
//  KazWeather
//
//  Created by 원태영 on 2/8/24.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

  private func setGlobalAppearence() {
    let appearence = UINavigationBarAppearance().configured {
      $0.backgroundColor = .weatherBackground
      $0.titleTextAttributes = [.foregroundColor: UIColor.weatherForeground]
      $0.largeTitleTextAttributes = [.foregroundColor: UIColor.weatherForeground]
    }
    
    UINavigationBar.appearance().standardAppearance = appearence
    UINavigationBar.appearance().compactAppearance = appearence
    UINavigationBar.appearance().scrollEdgeAppearance = appearence
    UIWindow.appearance().tintColor = .primary
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    setGlobalAppearence()
    
    return true
  }

  // MARK: UISceneSession Lifecycle
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    
  }
}

