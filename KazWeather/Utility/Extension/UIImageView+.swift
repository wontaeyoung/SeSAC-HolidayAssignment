//
//  UIImageView+.swift
//  KazWeather
//
//  Created by 원태영 on 2/8/24.
//

import UIKit
import Kingfisher

extension UIImageView {
  func setImage(from url: Resource?, with samplingSize: CGSize) {
    let downsamplingProcessor = DownsamplingImageProcessor(size: samplingSize)
    self.kf.indicatorType = .activity
    
    self.kf.setImage(
      with: url,
      options: [
        .processor(downsamplingProcessor),
        .scaleFactor(UIScreen.main.scale),
        .transition(.fade(0.2)),
        .cacheOriginalImage
      ]
    )
  }
}

