import Foundation
import RealmSwift

public typealias CallBack = (Bool, Error?) -> Void

public class DataManagerService:  DataManagerServiceProtocol {
    private var currencyService: CurrencyServiceProtocol
    
    init(currencyService: CurrencyServiceProtocol) {
        self.currencyService = currencyService
    }
    
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
    
    func getIncomes(for period: (Date, Date)) -> [IncomeDB] {
        let expenses = getAllIncomes()
        var neededExpenses = [IncomeDB]()
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
    
    func getMonthExpensesFor(period: TimePeriod) ->  [(key: String, value: Float)] {
        let monthExpenses = getMonthExpenses(getAllExpenses())
        guard let data = getMonthExpensesFor(period: period, monthExpenses) else {
            return [(key: String, value: Float)]()
        }
        return data
    }
    
    func getDayExpensesFor(period: TimePeriod) -> [(key: String, value: Float)] {
        let dayExpenses = getDayExpenses(getAllExpenses())
        guard let data = getDayExpensesFor(period: period, dayExpenses) else {
            return [(key: String, value: Float)]()
        }
        return data
    }
    
    func getCategoryExpensesFor(period: TimePeriod) -> [(key: String, value: Float)] {
        guard let data = getExpenses(for: period) else {return [(key: String, value: Float)]()}
        var arr = [(key: String, value: Float)]()
        let categories = sortExpensesByCategory(data)
        let defCurrency = UserDefaults.standard.string(forKey: AppConstants.defCurrency)
        categories.forEach { element in
            var sum: Float = 0.0
            element.value.forEach { expense in
                guard let value = expense.value?.toFloat() else {return}
                guard let defCur = defCurrency,
                    let cur = expense.currency else {return}
                if defCur == cur {
                    sum += value
                } else {
                   sum += currencyService.convert(from: Currency.init(from: cur), to: Currency.init(from: defCur), value: value)
                }
            }
            if sum != 0.0 {
                arr.append((key: element.key, value: round(sum)))
            }
        }
        arr.sort { f, s -> Bool in
            f.value >= s.value
        }
        return arr
    }
    
    private func getDayExpensesFor(period: TimePeriod,_ expenses: [(key: Date, value: Float)]) -> [(key: String, value: Float)]? {
        var start = Date()
        var end = Date()
        switch period {
            case .week:
                guard let sDate = Date().startOfWeek, let eDate = Date().endOfWeek else {return nil}
                start = sDate
                end = eDate
            case .month:
                guard let sDate = Date().startOfMonth, let eDate = Date().endOfMonth else {return nil}
                start = sDate
                end = eDate
            case .custom(let first, let sec):
                start = first
                end = sec
            default:
                return nil
        }
        var verifiedArr =  [(key: String, value: Float)]()
        expenses.forEach {
            if $0.key >= start && $0.key <= end {
                verifiedArr.append((key: $0.key.dayOfWeek(), value: $0.value))
            }
        }
        return verifiedArr
    }
    
    private func getMonthExpensesFor(period: TimePeriod,_ expenses: [(key: Date, value: Float)]) -> [(key: String, value: Float)]? {
        var start = Date()
        var end = Date()
        switch period {
            case .quarter:
                start = Date().quarter.0
                end =  Date().quarter.1
            case .year:
                start = Date().yearDates.0
                end = Date().yearDates.1
            case .custom(let first, let sec):
                guard let fDate = first.startOfMonth, let sDate = sec.endOfMonth else {return nil}
                start = fDate
                end = sDate
            default:
                return nil
        }
        var verifiedArr =  [(key: String, value: Float)]()
        expenses.forEach {
            if $0.key >= start && $0.key <= end {
                verifiedArr.append((key: $0.key.month(), value: $0.value))
            }
        }
        return verifiedArr
    }
    
    private func getDayExpenses(_ expenses: [CostDB]) -> [(key: Date, value: Float)] {
        let sortDates = sortExpensesByDay(expenses)
        var dict = [(key: Date, value: Float)]()
        let defCurrency = UserDefaults.standard.string(forKey: AppConstants.defCurrency)
        sortDates.forEach {
            var sum: Float = 0.0
            $0.value.forEach {
                guard let stringValue = $0.value,
                    let value = Float(stringValue) else {
                        return
                }
                guard let defCur = defCurrency,
                    let cur = $0.currency else {return}
                if defCur == cur {
                    sum += value
                } else {
                   sum += currencyService.convert(from: Currency.init(from: cur), to: Currency.init(from: defCur), value: value)
                }
            }
            guard let date = $0.value.first?.date else { return }
            dict.append((key: date, value: round(sum)))
        }
        return dict
    }
    
    private func getMonthExpenses(_ expenses: [CostDB]) -> [(key: Date, value: Float)] {
        let sortDates = sortExpensesByMonth(expenses)
        var dict = [(key: Date, value: Float)]()
        let defCurrency = UserDefaults.standard.string(forKey: AppConstants.defCurrency)
        sortDates.forEach {
            var sum: Float = 0.0
            $0.value.forEach {
                guard let stringValue = $0.value,
                    let value = Float(stringValue) else {
                        return
                }
                guard let defCur = defCurrency,
                    let cur = $0.currency else {return}
                if defCur == cur {
                    sum += value
                } else {
                   sum += currencyService.convert(from: Currency.init(from: cur), to: Currency.init(from: defCur), value: value)
                }
            }
            guard let date = $0.value.first?.date else { return }
            dict.append((key: date, value: round(sum)))
        }
        return dict
    }
    
    private func sortExpensesByDay(_ expenses: [CostDB]) -> [(key: String, value: [CostDB])] {
        var datesDictionary = [String: [CostDB]]()
        expenses.forEach {
            guard let date = $0.date else {
                return
            }
            let keyDate = date.dateWithLocale()
            if datesDictionary[keyDate] == nil {
                datesDictionary[keyDate] = expenses.filter {
                    guard let date = $0.date else {
                        return false
                    }
                    return date.dateWithLocale() == keyDate
                }
            }
        }
        
        let sortedKeys = datesDictionary.sorted(by: {
            guard let lDate = $0.value.first?.date, let rDate = $1.value.first?.date, lDate > rDate
                else { return false }
            return true
        })
        return sortedKeys
    }
    
    private func sortExpensesByMonth(_ expenses: [CostDB]) -> [(key: String, value: [CostDB])] {
        var datesDictionary = [String: [CostDB]]()
        expenses.forEach {
            guard let date = $0.date else {
                return
            }
            let keyDate = date.monthYearWithLocale()
            if datesDictionary[keyDate] == nil {
                datesDictionary[keyDate] = expenses.filter {
                    guard let date = $0.date else {
                        return false
                    }
                    return date.monthYearWithLocale() == keyDate
                }
            }
        }
        
        let sortedKeys = datesDictionary.sorted(by: {
            guard let lDate = $0.value.first?.date, let rDate = $1.value.first?.date, lDate > rDate
                else { return false }
            return true
        })
        return sortedKeys
    }
    
    private func sortExpensesByCategory(_ expenses: [CostDB]) -> [String: [CostDB]] {
           var dictionary = [String: [CostDB]]()
           expenses.forEach {
               guard let key = $0.category else {
                   return
               }
               if dictionary[key] == nil {
                   dictionary[key] = expenses.filter {
                       guard let category = $0.category else {
                           return false
                       }
                       return category == key
                   }
               }
           }
           return dictionary
       }
    
    private func getExpenses(for period: TimePeriod) -> [CostDB]? {
        var start = Date()
        var end = Date()
        switch period {
        case .week:
            guard let sDate = Date().startOfWeek, let eDate = Date().endOfWeek else {return nil}
            start = sDate
            end = eDate
        case .month:
            guard let sDate = Date().startOfMonth, let eDate = Date().endOfMonth else {return nil}
            start = sDate
            end = eDate
        case .custom(let first, let sec):
            start = first
            end = sec
        default:
            return nil
        }
        return getExpenses(for: (start, end))
    }
    
    func getMonthIncomesFor(period: TimePeriod) ->  [(key: String, value: Float)] {
        let monthIncomes = getMonthIncomes(getAllIncomes())
        guard let data = getMonthIncomesFor(period: period, monthIncomes) else {
            return [(key: String, value: Float)]()
        }
        return data
    }
    
    func getCategoryIncomesFor(period: TimePeriod) -> [(key: String, value: Float)] {
        guard let data = getIncomes(for: period) else {return [(key: String, value: Float)]()}
        var arr = [(key: String, value: Float)]()
        let categories = sortIncomesByCategory(data)
        let defCurrency = UserDefaults.standard.string(forKey: AppConstants.defCurrency)
        categories.forEach { element in
            var sum: Float = 0.0
            element.value.forEach { income in
                guard let value = income.value?.toFloat() else {return}
                guard let defCur = defCurrency,
                    let cur = income.currency else {return}
                if defCur == cur {
                    sum += value
                } else {
                   sum += currencyService.convert(from: Currency.init(from: cur), to: Currency.init(from: defCur), value: value)
                }
            }
            if sum != 0.0 {
                arr.append((key: element.key, value: round(sum)))
            }
        }
        arr.sort { f, s -> Bool in
            f.value >= s.value
        }
        return arr
    }
    
    private func getMonthIncomesFor(period: TimePeriod,_ incomes: [(key: Date, value: Float)]) -> [(key: String, value: Float)]? {
        var start = Date()
        var end = Date()
        switch period {
            case .quarter:
                start = Date().quarter.0
                end =  Date().quarter.1
            case .year:
                start = Date().yearDates.0
                end = Date().yearDates.1
            case .custom(let first, let sec):
                guard let fDate = first.startOfMonth, let sDate = sec.endOfMonth else {return nil}
                start = fDate
                end = sDate
            default:
                return nil
        }
        var verifiedArr =  [(key: String, value: Float)]()
        incomes.forEach {
            if $0.key >= start && $0.key <= end {
                verifiedArr.append((key: $0.key.month(), value: $0.value))
            }
        }
        return verifiedArr
    }
    
    private func getMonthIncomes(_ incomes: [IncomeDB]) -> [(key: Date, value: Float)] {
        let sortDates = sortIncomesByMonth(incomes)
        var dict = [(key: Date, value: Float)]()
        let defCurrency = UserDefaults.standard.string(forKey: AppConstants.defCurrency)
        sortDates.forEach {
            var sum: Float = 0.0
            $0.value.forEach {
                guard let stringValue = $0.value,
                    let value = Float(stringValue) else {
                        return
                }
                guard let defCur = defCurrency,
                    let cur = $0.currency else {return}
                if defCur == cur {
                    sum += value
                } else {
                   sum += currencyService.convert(from: Currency.init(from: cur), to: Currency.init(from: defCur), value: value)
                }
            }
            guard let date = $0.value.first?.date else { return }
            dict.append((key: date, value: round(sum)))
        }
        return dict
    }
    
    private func sortIncomesByDay(_ incomes: [IncomeDB]) -> [(key: String, value: [IncomeDB])] {
        var datesDictionary = [String: [IncomeDB]]()
        incomes.forEach {
            guard let date = $0.date else {
                return
            }
            let keyDate = date.dateWithLocale()
            if datesDictionary[keyDate] == nil {
                datesDictionary[keyDate] = incomes.filter {
                    guard let date = $0.date else {
                        return false
                    }
                    return date.dateWithLocale() == keyDate
                }
            }
        }
        
        let sortedKeys = datesDictionary.sorted(by: {
            guard let lDate = $0.value.first?.date, let rDate = $1.value.first?.date, lDate > rDate
                else { return false }
            return true
        })
        return sortedKeys
    }
    
    private func sortIncomesByMonth(_ incomes: [IncomeDB]) -> [(key: String, value: [IncomeDB])] {
        var datesDictionary = [String: [IncomeDB]]()
        incomes.forEach {
            guard let date = $0.date else {
                return
            }
            let keyDate = date.monthYearWithLocale()
            if datesDictionary[keyDate] == nil {
                datesDictionary[keyDate] = incomes.filter {
                    guard let date = $0.date else {
                        return false
                    }
                    return date.monthYearWithLocale() == keyDate
                }
            }
        }
        
        let sortedKeys = datesDictionary.sorted(by: {
            guard let lDate = $0.value.first?.date, let rDate = $1.value.first?.date, lDate > rDate
                else { return false }
            return true
        })
        return sortedKeys
    }
    
    private func sortIncomesByCategory(_ incomes: [IncomeDB]) -> [String: [IncomeDB]] {
           var dictionary = [String: [IncomeDB]]()
           incomes.forEach {
               guard let key = $0.category else {
                   return
               }
               if dictionary[key] == nil {
                   dictionary[key] = incomes.filter {
                       guard let category = $0.category else {
                           return false
                       }
                       return category == key
                   }
               }
           }
           return dictionary
       }
    
    private func getIncomes(for period: TimePeriod) -> [IncomeDB]? {
        var start = Date()
        var end = Date()
        switch period {
        case .week:
            guard let sDate = Date().startOfWeek, let eDate = Date().endOfWeek else {return nil}
            start = sDate
            end = eDate
        case .month:
            guard let sDate = Date().startOfMonth, let eDate = Date().endOfMonth else {return nil}
            start = sDate
            end = eDate
        case .custom(let first, let sec):
            start = first
            end = sec
        default:
            return nil
        }
        return getIncomes(for: (start, end))
    }
    
    private func round(_ value: Float) -> Float {
        let formatted = String(format: "%.2f", value)
        guard let formattedValue = Float(formatted) else {
            return 0.0
        }
        return formattedValue
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
