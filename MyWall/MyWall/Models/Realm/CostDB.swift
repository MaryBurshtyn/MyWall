import Foundation
import RealmSwift

class CostDB: Object {
    @objc dynamic var objectId = UUID().uuidString
    @objc dynamic var category: String?
    @objc dynamic var date: Date?
    @objc dynamic var value: String?
    @objc dynamic var currency: String?

    override class func primaryKey() -> String? {
        return "objectId"
    }
    
    init(category: String, date: Date, cost: String, currency: String, objectId: String) {
        self.category = category
        self.date = date
        self.value = cost
        self.currency = currency
        self.objectId = objectId
    }
    
    required init() {
        self.objectId = UUID().uuidString
        self.category = nil
        self.date = nil
        self.value = nil
        self.currency = nil
    }
}
extension Array where Element: CostDB {
    func contain(_ elem: Element) -> Bool {
        for el in self {
            if el.objectId == elem.objectId {
                return true
            }
        }
        return false
    }
}
