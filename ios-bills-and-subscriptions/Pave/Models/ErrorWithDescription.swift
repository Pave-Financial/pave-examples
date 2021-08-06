import Foundation


// Use this protocol to display errors in the apps
protocol ErrorWithDescription: Error {
	var errorDescription: String? { get }
}


// Use this struct for simple error with description
struct SimpleError: ErrorWithDescription {
	var errorDescription: String?

}

