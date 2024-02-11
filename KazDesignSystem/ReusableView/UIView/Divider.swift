import UIKit

public final class Divider: BaseView {
  
  public override func setAttribute() {
    self.backgroundColor = .borderColor
  }
  
  override public func setHierarchy() {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.heightAnchor.constraint(equalToConstant: 1).isActive = true
  }
}
