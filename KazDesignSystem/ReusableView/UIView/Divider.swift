import UIKit

public final class Divider: BaseView {
  
  public override func setAttribute() {
    self.backgroundColor = .borderColor
  }
  
  override public func setConstraint() {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.heightAnchor.constraint(equalToConstant: 0.7).isActive = true
  }
}
