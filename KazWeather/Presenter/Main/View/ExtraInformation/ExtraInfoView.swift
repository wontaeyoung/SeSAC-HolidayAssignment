//
//  ExtraInfoView.swift
//  KazWeather
//
//  Created by 원태영 on 2/14/24.
//

import UIKit
import KazDesignSystem
import SnapKit

final class ExtraInfoView: BaseView {
  
  
  // MARK: - UI
  private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionLayout()).configured {
    $0.register(
      ExtraInfoCollectionViewCell.self,
      forCellWithReuseIdentifier: ExtraInfoCollectionViewCell.identifier
    )
    $0.backgroundColor = .clear
  }
  
  // MARK: - Life Cycle
  override func setHierarchy() {
    self.addSubview(collectionView)
  }
  
  override func setConstraint() {
    collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  // MARK: - Method
  func makeCollectionLayout() -> UICollectionViewFlowLayout {
    return UICollectionViewFlowLayout().configured {
      let space: CGFloat = 10
      let globalInset: CGFloat = 16
      let size = UIScreen.main.bounds.width - space - globalInset * 2
      
      $0.itemSize = CGSize(width: size / 2, height: size / 2)
      $0.minimumLineSpacing = space
      $0.minimumInteritemSpacing = 0
      $0.scrollDirection = .vertical
    }
  }
  
  func setDelegate(with delegate: CollectionControllable) {
    self.collectionView.delegate = delegate
    self.collectionView.dataSource = delegate
  }
  
  func reloadData() {
    self.collectionView.reloadData()
  }
}
