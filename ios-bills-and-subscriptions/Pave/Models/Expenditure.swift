import Foundation


struct Expenditure {
    let normalizedMerchantName: String
    let merchantUuid: String
    let lastAmount: MoneyAmount
    let lastDescription: String
    let lastDate: Date
    let avgAmount: MoneyAmount
    let isoCurrencyCode: String
    let count: Int
    let avgPeriodDays: Double
    let normalizedFrequency: ExpenditureFrequency
    let nextAmount: MoneyAmount
    let nextDate: Date
    let deltaAmount: MoneyAmount
    let deltaPercent: Double
    let tag: String
    let transactions: [Transaction]?
	
	static func fromDTO(_ dto: ExpenditureDTO) -> Expenditure {
		let currency = Currency(code: dto.isoCurrencyCode)
		
		return Expenditure(
            normalizedMerchantName: dto.normalizedMerchantName,
            merchantUuid: dto.merchantUuid,
            lastAmount: MoneyAmount(currency: currency, amount: dto.lastAmount),
            lastDescription: dto.lastDescription, lastDate: dto.lastDate,
            avgAmount: MoneyAmount(currency: currency, amount: dto.avgAmount),
            isoCurrencyCode: dto.isoCurrencyCode,
            count: dto.count,
            avgPeriodDays: dto.avgPeriodDays,
            normalizedFrequency: dto.normalizedFrequency,
            nextAmount: MoneyAmount(currency: currency, amount: dto.nextAmount),
            nextDate: dto.nextDate,
            deltaAmount: MoneyAmount(currency: currency, amount: dto.deltaAmount),
            deltaPercent: dto.deltaPercent,
            tag: dto.tags.first ?? "",
            transactions: Expenditure.getTransactionList(dto.transactions)
		)
	}
    
    private static func getTransactionList(_ transactionDtoList: [TransactionsDTO]?) -> [Transaction]? {
        if let transactionDtoList = transactionDtoList {
            return transactionDtoList.map { Transaction.fromDTO($0) }
        } else {
            return nil
        }
    }
}


extension Expenditure {
	var merchantNameAbbreviation: String {
		let words = normalizedMerchantName.split(separator: " ").map { String($0) }
		
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


