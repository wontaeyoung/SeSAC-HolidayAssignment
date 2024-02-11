import UIKit
import SnapKit

public final class Divider: BaseView {
  
  public override func setAttribute() {
    self.backgroundColor = .borderColor
  }
  
  override public func setHierarchy() {
    self.snp.makeConstraints { make in
      make.height.equalTo(1)
    }
  }
}
