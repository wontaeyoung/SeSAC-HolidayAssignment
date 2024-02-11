import UIKit
import SnapKit

public final class CardView: BaseView {
  
  // MARK: - Life Cycle
  public override func setAttribute() {
    self.layer.cornerRadius = 15
    self.layer.opacity = 0.4
  }
}
