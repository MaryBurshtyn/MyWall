import Foundation
import FirebaseFirestore

protocol CommonParser {
    associatedtype OutputType
    func parse(documentId: String, dictionary: [String: Any]) throws -> OutputType
    func parse(snapshot: QuerySnapshot) throws -> [OutputType]
}

extension CommonParser {
    func parse(snapshot: QuerySnapshot) throws -> [OutputType] {
        do {
            let items: [OutputType] = try snapshot.documents.map({ try parse(documentId: $0.documentID,
                                                                             dictionary: $0.data()) })
            return items
        } catch {
            throw error
        }
    }
}
