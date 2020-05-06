import Foundation
import RealmSwift

class CostDB: Object {
    @objc dynamic var objectId = UUID().uuidString
    @objc dynamic var category: String?
    @objc dynamic var date: Date?
    @objc dynamic var cost: String?
    @objc dynamic var currency: String?

    override class func primaryKey() -> String? {
        return "objectId"
    }
}
