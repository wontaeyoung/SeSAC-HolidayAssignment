//
//  SplashViewController.swift
//  KazWeather
//
//  Created by 원태영 on 2/9/24.
//

import UIKit
import Lottie

final class SplashViewController: BaseViewController {
  
  // MARK: - UI
  private lazy var splashView = LottieAnimationView(name: "Splash").configured {
    $0.frame = view.bounds
    $0.contentMode = .scaleAspectFit
    $0.loopMode = .loop
  }
  
  
  // MARK: - Life Cycle
  override func setHierarchy() {
    view.addSubview(splashView)
  }
  
  override func setAttribute() {
    splashView.play()
  }
}

