import Foundation

extension String {
	func byCapitalizingFirstLetter() -> String {
		let first = prefix(1).capitalized
		let other = dropFirst()
		return first + other
	}
}
