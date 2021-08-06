import Foundation
import UIKit


/// Class that represents label with insets
class InsetLabel: UILabel {
	
	var insets: UIEdgeInsets = UIEdgeInsets(top: 1, left: 10, bottom: 1, right: 10) {
		didSet {
			self.setNeedsDisplay()
		}
	}

	override func drawText(in rect: CGRect) {
		super.drawText(in: rect.inset(by: insets))
	}
	
	override public var intrinsicContentSize: CGSize {
		var intrinsicSuperViewContentSize = super.intrinsicContentSize
		intrinsicSuperViewContentSize.height += insets.top + insets.bottom
		intrinsicSuperViewContentSize.width += insets.left + insets.right
		return intrinsicSuperViewContentSize
	}
}
