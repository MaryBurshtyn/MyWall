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
    
    init(category: String, date: Date, cost: String, currency: String, objectId: String) {
        self.category = category
        self.date = date
        self.cost = cost
        self.currency = currency
        self.objectId = objectId
    }
    
    required init() {
        self.objectId = UUID().uuidString
        self.category = nil
        self.date = nil
        self.cost = nil
        self.currency = nil
    }
}
