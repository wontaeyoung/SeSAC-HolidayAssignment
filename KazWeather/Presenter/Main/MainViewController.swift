//
//  MainViewController.swift
//  KazWeather
//
//  Created by 원태영 on 2/11/24.
//

import UIKit
import KazDesignSystem
import SnapKit

final class MainViewController: BaseViewController, ViewModelController {
  
  
  // MARK: - UI
  private let mainView = MainView()
  private lazy var bottomToolbar = UIToolbar().configured {
    let mapItem = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: #selector(mapItemTapped))
    let cityItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(cityItemTapped))
    let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    $0.setItems([mapItem, spaceItem, cityItem], animated: false)
  }
  
  
  // MARK: - Property
  let viewModel: MainViewModel
  
  
  // MARK: - Initializer
  init(viewModel: MainViewModel) {
    self.viewModel = viewModel
    
    super.init()
  }
  
  
  // MARK: - Life Cycle
  override func loadView() {
    self.view = mainView
  }
  
  override func setHierarchy() {
    view.addSubview(bottomToolbar)
  }
  
  override func setConstraint() {
    bottomToolbar.snp.makeConstraints { make in
      make.horizontalEdges.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  override func bind() {
    viewModel.cityWeather.subscribe { cityWeather in
      self.mainView.updateCurrentWeatherUI(with: cityWeather)
    }
    
    viewModel.forecastBy3H.subscribe { forecastBy3H in
      self.mainView.updateForecastWeatherUI(with: forecastBy3H)
    }
  }
  
  
  // MARK: - Method
  @objc private func mapItemTapped() {
    
  }
  
  @objc private func cityItemTapped() {
    
  }
}
