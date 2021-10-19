import Foundation


enum DataProviderError: ErrorWithDescription {
	
	case decodingFailed(error: String)

	var errorDescription: String? {
		switch self {
		case .decodingFailed(let descr):
			return "Decoding response failed: \(descr)"
		}
	}
}


/// This class provides data. It's good idea to cache data in it.
class DataProvider {
	
	private var networkService = NetworkService()
	
	typealias ExpendituresCompletion = (Result<[Expenditure], Error>) -> ()
	
	func getExpenses(completion: @escaping ExpendituresCompletion) {
		networkService.performRequest(NetworkService.Method.recurringExpenditures) { (result: Result<Data, NetworkServiceError>) in
			switch result {
			case .failure(let error):
				completion(.failure(error))
			case .success(let data):
				do {
					let decoder = JSONDecoder()
					decoder.keyDecodingStrategy = .convertFromSnakeCase
					decoder.dateDecodingStrategy = .formatted(.dateFormatter)
					let response = try decoder.decode(RecurringExpendituresResponse.self, from: data)
					let expenditures = response.recurringExpenditures.map { Expenditure.fromDTO($0)}
					completion(.success(expenditures))
				} catch let e {
					print("\(#function) \(e)")
					completion(.failure(DataProviderError.decodingFailed(error: e.localizedDescription)))
					return
				}
			}
		}
	}
}


/// Response we get on recurringExpenditures call
struct RecurringExpendituresResponse: Decodable {
	let userId: String
	let from: Date
	let to: Date
	let recurringExpenditures: [ExpenditureDTO]
}

/// Formats date that we get from backend
extension DateFormatter {
	static let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter
	}()
}

/// This is a data transfer object for Expenditure. Data from server gets deserialised into it.
/// Do not use for other reasons than serialization or deserialization. Use Expenditure
struct ExpenditureDTO: Decodable  {
	let tags: [String]
	let normalizedMerchantName: String
	let lastAmount: Double
	let lastDescription: String
	let lastDate: Date
	let previousAmount: Double
	let previousDate: Date
	let deltaAmount: Double
	let deltaPercent: Double
	let avgAmount: Double
	let isoCurrencyCode: String
	let count: Int
	let avgPeriodDays: Double
	let normalizedFrequency: ExpenditureFrequency
}
