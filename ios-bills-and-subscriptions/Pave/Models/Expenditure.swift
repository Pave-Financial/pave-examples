import Foundation


struct Expenditure {
    let tag: String
	let merchantName: String
	
	let lastTransactionAmount: MoneyAmount
	let lastTransactionDescription: String
	let lastTransactionDate: Date
	
	let previousTransactionAmount: MoneyAmount
	let previousTransactionDate: Date
	
	let transactionDeltaAmount: MoneyAmount
	let transactionDeltaPercent: Double
	
	let avgAmount: MoneyAmount
	
	let transactionCount: Int
	let avgPeriodDays: Double
	
	let normalizedFrequency: ExpenditureFrequency
	
	static func fromDTO(_ dto: ExpenditureDTO) -> Expenditure {
		let currency = Currency(code: dto.isoCurrencyCode)
		
		return Expenditure(
            tag: dto.tags.first ?? "",
			merchantName: dto.normalizedMerchantName,
			lastTransactionAmount: MoneyAmount(currency: currency, amount: dto.lastAmount),
			lastTransactionDescription: dto.lastDescription,
			lastTransactionDate: dto.lastDate,
			previousTransactionAmount: MoneyAmount(currency: currency, amount: dto.previousAmount),
			previousTransactionDate: dto.previousDate,
			transactionDeltaAmount: MoneyAmount(currency: currency, amount: dto.deltaAmount),
			transactionDeltaPercent: dto.deltaPercent,
			avgAmount: MoneyAmount(currency: currency, amount: dto.avgAmount),
			transactionCount: dto.count,
			avgPeriodDays: dto.avgPeriodDays,
			normalizedFrequency: dto.normalizedFrequency
		)
	}
}


extension Expenditure {
	var merchantNameAbbreviation: String {
		let words = merchantName.split(separator: " ").map { String($0) }
		
		var lettersArray = [String]()
		for string in words {
			if let letter = string.first {
				lettersArray.append(String(letter))
			}
		}
		
		switch lettersArray.count {
		case 0:
			return ""
		case 1:
			return lettersArray.first!
		default:
			return lettersArray.first! + lettersArray.last!
		}
	}
}

enum ExpenditureFrequency: String, Decodable {
	case daily, weekly, biweekly, monthly, bimonthly, quarterly, annual
	case semiAnnual = "semi_annual"
}


