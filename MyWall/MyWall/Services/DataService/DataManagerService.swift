import Foundation
import RealmSwift
public class DataManagerService {

//    func getNextObjectId() -> Int? {
//        let items = getAllRepoItems()
//        if !items.isEmpty {
//            guard let number = items.max(by: { (left, right) -> Bool in
//                return left.objectId < right.objectId
//            })?.objectId else { return nil }//.value(forKey: "objectId") as? Int else { return }
//            return number + 1
//        } else {
//            return 1
//        }
//    }

//    func deleteTripItems(_ items: [TripInfo]) {
//        items.forEach {
//            self.delete($0)
//        }
//    }
//
//    func uploadToRepo<T: Object>(_ data: [T], _ tripId: String?, completion: CallBack? = nil) {
//        data.forEach { (data) in
//            write(data, shouldUpdate: false)
//        }
//    }
//
//    func getAllRepoItems() -> [TripInfo] {
//        guard let items = realm?.objects(TripInfo.self).toArray() else {
//            return []
//        }
//        return items
//    }
//
//    func getLastItem() -> LastTripInfo? {
//        guard let lastItem = realm?.objects(LastTripInfo.self).last else { return nil }
//        return lastItem
//    }
//
//    func deleteLastItems() {
//        guard let lastItems = realm?.objects(LastTripInfo.self) else { return }
//        delete(lastItems)
//    }
//
//    func deleteAllItems() {
//        deleteAll()
//    }
//
//    func uploadLastItem(_ item: LastTripInfo) {
//        write(item, shouldUpdate: false)
//    }
//
//    func makeLastPoint(_ state: String) {
//        guard let lastItem = realm?.objects(TripInfo.self).last else {
//            return
//        }
//        write(lastItem, shouldUpdate: false) {
//            lastItem.type = state
//        }
//    }
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
            print(error)
        }
    }

    private func delete<T: Object>(_ objects: Results<T>) {
        do {
            try realm?.write {
                realm?.delete(objects)
            }
        } catch {
            print(error)
        }
    }

    private func delete<T: Object>(_ object: T) {
        do {
            try realm?.write {
                realm?.delete(object)
            }
        } catch {
            print(error)
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
            print(error)
        }
    }
}

extension Results {
    func toArray() -> [Element] {
        return compactMap { $0 }
    }
}
