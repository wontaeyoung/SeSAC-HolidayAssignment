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
    
    mainView.setDelegate(with: self)
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
      self.mainView.reloadCollectionData()
    }
    
    viewModel.forecastBy3H3D.subscribe { forecastBy3H in
      self.mainView.updateForecastWeatherUI(with: forecastBy3H)
    }
    
    viewModel.forecastBy5D.subscribe { forecastBy5D in
      self.mainView.reloadTableData()
    }
  }
  
  
  // MARK: - Method
  @objc private func mapItemTapped() {
    
  }
  
  @objc private func cityItemTapped() {
    mainView.reloadTableData()
  }
}

extension MainViewController: TableControllable {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.forecastBy5D.current.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: DailyForecastTableViewCell.identifier,
      for: indexPath
    ) as! DailyForecastTableViewCell
    
    let data: CityWeather = viewModel.forecastBy5D.current[indexPath.row]
    cell.updateUI(with: data, row: indexPath.row)
    cell.selectionStyle = .none
    
    return cell
  }
}

extension MainViewController: CollectionControllable {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return ExtraInfo.allCases.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: ExtraInfoCollectionViewCell.identifier,
      for: indexPath
    ) as! ExtraInfoCollectionViewCell
    
    let data = viewModel.cityWeather.current
    let info = ExtraInfo.allCases[indexPath.row]
    cell.updateUI(with: data, info: info)
    
    return cell
  }
}

enum ExtraInfo: CaseIterable {
  case wind
  case cloud
  case pressure
  case humidity
  
  var title: String {
    switch self {
      case .wind:
        return "바람 속도"
        
      case .cloud:
        return "구름"
        
      case .pressure:
        return "기압"
        
      case .humidity:
        return "습도"
    }
  }
  
  var iconSymbol: String {
    switch self {
      case .wind:
        return "wind"
        
      case .cloud:
        return "cloud.fill"
        
      case .pressure:
        return "water.waves.and.arrow.down"
        
      case .humidity:
        return "humidity.fill"
    }
  }
}
