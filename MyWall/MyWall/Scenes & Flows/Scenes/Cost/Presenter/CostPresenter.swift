import Foundation
import Reachability

class CostPresenter {

    unowned var view: CostViewProtocol
    unowned var navigator: SceneNavigatorProtocol
    var dataManagerService: DataManagerServiceProtocol
    var api: ApiProtocol
    var reachability: Reachability?
    var costs = [CostDB]()
    let globalGroup = DispatchGroup()
    var datesDictionary = [(key: String, value: [CostDB])]()
    
    init(view: CostViewProtocol,
         navigator: SceneNavigatorProtocol,
         dataManagerService: DataManagerServiceProtocol,
         reachability: Reachability?,
         api: ApiProtocol) {
        
        self.view = view
        self.navigator = navigator
        self.dataManagerService = dataManagerService
        self.reachability = reachability
        self.api = api
    }
    
    private func synchronizeDatabases() {
        let localData = dataManagerService.getAllExpenses()
        let group = DispatchGroup()
        var apiData: [CostDB]?
        group.enter()
        self.api.getExpenses { result in
            switch result {
            case .success(let data):
                apiData = data
                group.leave()
            case .failure(let err):
                log.info("Couldnt get api data cause: \(err.localizedDescription)")
                group.leave()
            }
        }
        group.wait()
        guard let apiValues = apiData else {
            globalGroup.leave()
            return
        }
        let apiDifference = localData.difference(from: apiValues)
        self.api.sendExpenses(apiDifference)
        let localDiff = apiValues.difference(from: localData)
        self.dataManagerService.uploadToRepo(localDiff, completion: nil)
        globalGroup.leave()
    }
    
    private func makeDatesDictionary() {
        var datesDictionary = [String: [CostDB]]()
        costs.forEach {
            guard let date = $0.date else {
                return
            }
            let keyDate = date.dateWithLocale()
            if datesDictionary[keyDate] == nil {
                datesDictionary[keyDate] = costs.filter {
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
        var sortedValues = [(key: String, value: [CostDB])]()
        sortedKeys.forEach {
            let sortedDates = $0.value.sorted(by: {
                guard let lDate = $0.date, let rDate = $1.date, lDate > rDate
                    else { return false }
                return true
            })
            sortedValues.append((key: $0.key, value: sortedDates))
        }
        self.datesDictionary = sortedValues
    }
}

// MARK: - CostPresenterProtocol

extension CostPresenter: CostPresenterProtocol {
    func handleAddButtonTapped() {
        view.openExpensesDialog()
    }
    
    func handleViewDidLoad() {
        view.showPreloader()
        if let isInternetConnected = self.reachability?.connection, isInternetConnected != .unavailable {
            //globalGroup.enter()
            //self.synchronizeDatabases()
            //globalGroup.wait()
        }
        self.costs = self.dataManagerService.getAllExpenses()
        self.costs = self.costs.sorted(by: {
            guard let fDate = $0.date, let sDate = $1.date else {
                return false
            }
            return fDate.compare(sDate) == .orderedAscending
        })
        makeDatesDictionary()
        self.view.setCosts(costs: datesDictionary)
        self.view.hidePreloader()
    }
    
    func handleUpdateExpensesList(expenses: [CostDB]) {
        dataManagerService.uploadToRepo(expenses, completion: nil)
        guard let isInternetConnected = reachability?.connection, isInternetConnected != .unavailable else {
            return
        }
        api.sendExpenses(expenses)
        costs.append(contentsOf: expenses)
        makeDatesDictionary()
        view.setCosts(costs: datesDictionary)
    }
}
extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        var thisSet = Set(self)
        let otherSet = Set(other)
        thisSet.formSymmetricDifference(otherSet)
        return Array(thisSet)
    }
}
//dispatch group
