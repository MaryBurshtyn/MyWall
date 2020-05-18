import Foundation
import FirebaseFirestore

class IncomeParser: CommonParser {
    typealias OutputType = IncomeDB
    
    func parse(documentId: String, dictionary: [String: Any]) throws -> IncomeDB {
        guard let category = dictionary[FirestoreCollections.usersData.category] as? String,
            let income = dictionary[FirestoreCollections.usersData.income] as? String,
            let currency = dictionary[FirestoreCollections.usersData.currency] as? String,
            let date = dictionary[FirestoreCollections.usersData.date] as? Timestamp else {
                throw AppError.parsingFailure("Error parsing item: \(self)")
        }
        return IncomeDB(category: category, date: date.dateValue(), income: income, currency: currency, objectId: documentId)
    }
}
