import Foundation

class GraphicsPresenter {

    unowned var view: GraphicsViewProtocol
    unowned var navigator: SceneNavigatorProtocol
    var dataManagerService: DataManagerServiceProtocol
    
    init(view: GraphicsViewProtocol,
         navigator: SceneNavigatorProtocol,
         dataManagerService: DataManagerServiceProtocol) {
        
        self.view = view
        self.navigator = navigator
        self.dataManagerService = dataManagerService
    }
    
    private func getIncomes() -> Float {
        var sum: Float = 0.0
        let incomes = dataManagerService.getIncomes(for: Date())
        incomes.forEach { element in
            guard let income = element.income,
                let intValue = income.toFloat() else {
                return
            }
            sum += intValue
        }
        return sum
    }
    
    private func getExpenses() -> Float {
        var sum: Float = 0.0
        let expenses = dataManagerService.getExpenses(for: Date())
        expenses.forEach { element in
           guard let income = element.cost,
               let intValue = income.toFloat() else {
               return
           }
           sum += intValue
        }
        return sum
    }
    
    private func getMonthExpensesFor(period: TimePeriod) ->  [(key: String, value: Float)]{
        let monthExpenses = getMonthExpenses(dataManagerService.getAllExpenses())
        guard let data = getMonthExpensesFor(period: period, monthExpenses) else {
            return [(key: String, value: Float)]()
        }
        return data
    }
    
    private func getDayExpensesFor(period: TimePeriod) -> [(key: String, value: Float)] {
        let dayExpenses = getDayExpenses(dataManagerService.getAllExpenses())
        guard let data = getDayExpensesFor(period: period, dayExpenses) else {
            return [(key: String, value: Float)]()
        }
        return data
    }
    
    private func getCategoryExpensesFor(period: TimePeriod) -> [(key: String, value: Float)] {
        guard let data = getExpenses(for: period) else {return [(key: String, value: Float)]()}
        var arr = [(key: String, value: Float)]()
        let categories = sortByCategory(data)
        categories.forEach { element in
            var sum: Float = 0.0
            element.value.forEach { expense in
                guard let value = expense.cost?.toFloat() else {return}
                sum += value
            }
            if sum != 0.0 {
                arr.append((key: element.key, value: sum))
            }
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
        let sortDates = sortByDay(expenses)
        var dict = [(key: Date, value: Float)]()
        sortDates.forEach {
            var sum: Float = 0.0
            $0.value.forEach {
                guard let stringValue = $0.cost,
                    let value = Float(stringValue) else {
                        return
                }
                sum += value
            }
            guard let date = $0.value.first?.date else { return }
            dict.append((key: date, value: sum))
        }
        return dict
    }
    
    private func getMonthExpenses(_ expenses: [CostDB]) -> [(key: Date, value: Float)] {
        let sortDates = sortByMonth(expenses)
        var dict = [(key: Date, value: Float)]()
        sortDates.forEach {
            var sum: Float = 0.0
            $0.value.forEach {
                guard let stringValue = $0.cost,
                    let value = Float(stringValue) else {
                        return
                }
                sum += value
            }
            guard let date = $0.value.first?.date else { return }
            dict.append((key: date, value: sum))
        }
        return dict
    }
    
    private func sortByDay(_ expenses: [CostDB]) -> [(key: String, value: [CostDB])] {
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
    
    private func sortByMonth(_ expenses: [CostDB]) -> [(key: String, value: [CostDB])] {
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
    
    private func sortByCategory(_ expenses: [CostDB]) -> [String: [CostDB]] {
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
        return dataManagerService.getExpenses(for: (start, end))
    }
}

// MARK: - SplashPresenterProtocol

extension GraphicsPresenter: GraphicsPresenterProtocol {
    func handleSettingsChoosed(sumType: SumType, period: TimePeriod) {
        switch sumType {
        case .day:
            view.setChartData(getDayExpensesFor(period: period))
        case .month:
            view.setChartData(getMonthExpensesFor(period: period))
        case .category:
            view.setChartData(getCategoryExpensesFor(period: period))
        }
    }
    
    func handleViewWillAppear() {
        view.setProgress(incomes: getIncomes(), expenses: getExpenses())
        view.setChartData(getDayExpensesFor(period: .week))
    }
}

extension String {
    func toFloat() -> Float? {
        guard let value = Float(self) else {
            return nil
        }
        return value
    }
}
