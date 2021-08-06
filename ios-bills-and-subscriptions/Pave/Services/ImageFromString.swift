import Foundation
import UIKit


extension String {
	
	// we generate image from string 
	func image(size: CGSize = CGSize(width: 50, height: 50), textSize: Int = 18, textColor: UIColor = UIColor.white) -> UIImage? {
		// we generate random color depending on string contents
		let backgroundColor = UIColor(
			red: CGFloat(Double(hash % 3) / 3.0),
			green: CGFloat(Double(hash % 5) / 5.0),
			blue: CGFloat(Double(hash % 7) / 7.0),
			alpha: 0.7
		)
		
		let attributes = [
			NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(textSize), weight: .semibold),
			NSAttributedString.Key.foregroundColor: textColor
		]
		
		let textSize = (self as NSString).size(withAttributes: attributes)
		
		return UIGraphicsImageRenderer(size: size).image { context in
			backgroundColor.setFill()
			context.fill(CGRect(origin: .zero, size: size))
			
			(self as NSString).draw(
				in: CGRect(
					origin: CGPoint(x: (size.width - textSize.width) / 2, y: (size.height - textSize.height) / 2),
					size: textSize
				),
				withAttributes: attributes
			)
		}
	}
	
}
