import UIKit
import SnapKit

public final class CardView: BaseView {
  
  // MARK: - Life Cycle
  public override func setAttribute() {
    self.layer.cornerRadius = 15
    self.backgroundColor = .weatherBackground.withAlphaComponent(0.4)
  }
}

class ViewController: BaseViewController {
  
  let backgroundImageView = UIImageView()
  let divider = Divider()
  let cardView = CardView()
  let imageLabel = IconLabel(
    symbol: "calendar",
    text: "3시간 간격의 일기예보"
  )
  
  
  override func setAttribute() {
    view.backgroundColor = .white
    view.addSubview(backgroundImageView)
    view.addSubview(cardView)
    view.addSubview(divider)
    view.addSubview(imageLabel)
    
    backgroundImageView.image = .clouds
    
    backgroundImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    cardView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.height.equalTo(200)
      make.horizontalEdges.equalToSuperview()
    }
    
    imageLabel.snp.makeConstraints { make in
      make.top.equalTo(cardView).offset(8)
      make.horizontalEdges.equalTo(cardView).inset(8)
    }
    
    divider.snp.makeConstraints { make in
      make.top.equalTo(imageLabel.snp.bottom).offset(4)
      make.horizontalEdges.equalTo(cardView)
    }
  }
}
