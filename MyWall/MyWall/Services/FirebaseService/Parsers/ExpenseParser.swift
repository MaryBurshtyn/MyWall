import Foundation
import FirebaseFirestore

class ExpenseParser: CommonParser {
    typealias OutputType = CostDB
    
    func parse(documentId: String, dictionary: [String: Any]) throws -> CostDB {
        guard let category = dictionary[FirestoreCollections.usersData.category] as? String,
            let cost = dictionary[FirestoreCollections.usersData.cost] as? String,
            let currency = dictionary[FirestoreCollections.usersData.currency] as? String,
            let date = dictionary[FirestoreCollections.usersData.date] as? Timestamp else {
                throw AppError.parsingFailure("Error parsing item: \(self)")
        }
        return CostDB(category: category, date: date.dateValue(), cost: cost, currency: currency, objectId: documentId)
    }
}
