import Foundation


/// Use this struct for money
struct MoneyAmount: Equatable, Comparable {
	enum MoneyError: Error {
		case differentCurrencies
	}
		
	var currency: Currency
	var amount: Double
	
	static var zero: MoneyAmount = MoneyAmount(currency: .unknown, amount: 0)
	
	// MARK: - Math
	
	static func == (lhs: MoneyAmount, rhs: MoneyAmount) -> Bool {
		if lhs.currency == rhs.currency {
			return fabs(lhs.amount - rhs.amount) <= 0.01 // floats are equal if they differ by less than 0.01.
		}
		return false
	}
	
	static func < (lhs: MoneyAmount, rhs: MoneyAmount) -> Bool {
		if lhs == rhs {
			return false
		}
		return lhs.amount < rhs.amount
	}
	
	static func +(lhs: MoneyAmount, rhs: MoneyAmount) throws -> MoneyAmount {
		if lhs == zero {
			return rhs
		} else if rhs == zero {
			return lhs
		}
		
		if lhs.currency == rhs.currency {
			return MoneyAmount(currency: lhs.currency, amount: lhs.amount + rhs.amount)
		} else {
			throw MoneyError.differentCurrencies
		}
	}
	
	static func +=(lhs: inout MoneyAmount, rhs: MoneyAmount) throws {
		lhs = try lhs + rhs
	}
	
	// MARK: - Representation
	
	/// String representation of money
	/// - Parameter showSign: if true, we show `+` for positive or zero numbers. for negative numbers sign is always shown
	func string(showSign: Bool = false) -> String {
		if amount >= 0 {
			var result = "\(currency.sign)\(String(format: "%.2f", amount))"
			if showSign {
				result = "+" + result
			}
			return result
		} else {
			return "-\(currency.sign)\(String(format: "%.2f", -amount))"
		}
	}
}


/// Returns if two doubles are equal
/// - Discussion:
/// 	since doubles are stored with Exponent encoding (https://en.wikipedia.org/wiki/Double-precision_floating-point_format#Exponent_encoding),
/// 	we can't compare them on equality directly, because at one point of time double can be 3.00000002 and on the other 3.00000021.
///		because of this we compare them with 0.01 precision.
///		for example, 0.01 != 0.02, but 0.01 == 0.011
func doubleEqual(_ a: Double, _ b: Double) -> Bool {
	return fabs(a - b) < 0.01
}

struct Currency: Equatable {
	var code: String
	var sign: String {
		switch self.code {
		case "USD":
			return "$"
		case "EUR":
			return "€"
		default:
			return code
		}
	}
	
	static let unknown = Currency(code: "")
}


