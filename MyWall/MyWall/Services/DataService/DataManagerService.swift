import Foundation
import RealmSwift

public typealias CallBack = (Bool, Error?) -> Void

public class DataManagerService:  DataManagerServiceProtocol {

    func deleteExpenses(_ items: [CostDB]) {
        items.forEach {
            self.delete($0)
        }
    }
    
    func deleteIncomes(_ items: [IncomeDB]) {
        items.forEach {
            self.delete($0)
        }
    }

    func uploadToRepo<T: Object>(_ data: [T], completion: CallBack? = nil) {
        data.forEach { (data) in
            write(data, shouldUpdate: false)
        }
    }

    func getAllExpenses() -> [CostDB] {
        guard let items = realm?.objects(CostDB.self).toArray() else {
            return []
        }
        return items
    }
    
    func getAllIncomes() -> [IncomeDB] {
        guard let items = realm?.objects(IncomeDB.self).toArray() else {
            return []
        }
        return items
    }
    
    func deleteAllItems() {
        deleteAll()
    }
    
    func getExpenses(for month: Date) -> [CostDB] {
        let expenses = getAllExpenses()
        var neededExpenses = [CostDB]()
        expenses.forEach { element in
            if element.date?.month() == month.month() {
                neededExpenses.append(element)
            }
        }
        return neededExpenses
    }
    
    func getExpenses(for period: (Date, Date)) -> [CostDB] {
        let expenses = getAllExpenses()
        var neededExpenses = [CostDB]()
        expenses.forEach { element in
            guard let date = element.date else {
                return
            }
            if date > period.0 && date < period.1 {
               neededExpenses.append(element)
           }
        }
        return neededExpenses
    }
    
    func getIncomes(for month: Date) -> [IncomeDB] {
        let incomes = getAllIncomes()
        var neededIncomes = [IncomeDB]()
        incomes.forEach { element in
            if element.date?.month() == month.month() {
                neededIncomes.append(element)
            }
        }
        return neededIncomes
    }
}

extension DataManagerService {

    var realm: Realm? {
        guard let realm = try? Realm()
            else { return nil }
        return realm
    }

    private func deleteAll() {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch {
            log.error(error)
        }
    }

    private func delete<T: Object>(_ objects: Results<T>) {
        do {
            try realm?.write {
                realm?.delete(objects)
            }
        } catch {
            log.error(error)
        }
    }

    private func delete<T: Object>(_ object: T) {
        do {
            try realm?.write {
                realm?.delete(object)
            }
        } catch {
            log.error(error)
        }
    }

    private func write(_ data: Object, shouldUpdate: Bool = false, change: (() -> Void)? = nil) {
        do {
            let realm = try Realm()
            let writeAction = {
                change?()
                shouldUpdate ? realm.add(data, update: .all): realm.add(data)
            }
            if realm.isInWriteTransaction {
                writeAction()
            } else {
                try realm.write {
                    writeAction()
                }
            }
        } catch let error {
            log.error(error)
        }
    }
}

extension Results {
    func toArray() -> [Element] {
        return compactMap { $0 }
    }
}
