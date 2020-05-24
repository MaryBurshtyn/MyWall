import Foundation
import Reachability
class IncomePresenter {

    unowned var view: IncomeViewProtocol
    unowned var navigator: SceneNavigatorProtocol
    var dataManagerService: DataManagerServiceProtocol
    var api: ApiProtocol
    var reachability: Reachability?
    var incomes = [IncomeDB]()
    let globalGroup = DispatchGroup()
    var datesDictionary = [(key: String, value: [IncomeDB])]()
    var apiData = [IncomeDB]()
    
    init(view: IncomeViewProtocol,
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
    
    private func makeDatesDictionary() {
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
        var sortedValues = [(key: String, value: [IncomeDB])]()
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
    
    private func synchronizeDatabases() {
           let localData = dataManagerService.getAllIncomes()
           if apiData.count == 0 {
               return
           }
           let apiDifference = difference(this: localData, that: apiData)
           if apiDifference.count != 0 {
               api.sendIncomes(apiDifference)
           }
           let localDiff = difference(this: apiData, that: localData)
           if localDiff.count != 0 {
               dataManagerService.uploadToRepo(localDiff, completion: nil)
           }
       }
    
    private func difference(this:  [IncomeDB], that: [IncomeDB]) -> [IncomeDB] {
           var diff = [IncomeDB]()
           this.forEach { (elem) in
               if !that.contain(elem) {
                   diff.append(elem)
               }
           }
           return diff
    }
    
    private func getApiData() {
        self.api.getIncomes { [weak self] result in
            switch result {
            case .success(let data):
                self?.apiData = data
                self?.globalGroup.leave()
            case .failure(let err):
                log.info("Couldnt get api data cause: \(err.localizedDescription)")
                self?.globalGroup.leave()
            }
        }
    }
    
    private func setData() {
        incomes = dataManagerService.getAllIncomes()
        incomes = incomes.sorted(by: {
            guard let fDate = $0.date, let sDate = $1.date else {
                return false
            }
            return fDate.compare(sDate) == .orderedAscending
        })
        makeDatesDictionary()
        view.setIncomes(incomes: datesDictionary)
    }
}

// MARK: - SplashPresenterProtocol

extension IncomePresenter: IncomePresenterProtocol {
    func handleViewDidLoad() {
        view.showPreloader()
        if let isInternetConnected = self.reachability?.connection, isInternetConnected != .unavailable {
            globalGroup.enter()
            getApiData()
            globalGroup.notify(queue: .main) {
                self.synchronizeDatabases()
                self.setData()
                self.view.hidePreloader()
            }
        } else {
            setData()
            view.hidePreloader()
        }
    }
    
    func handleAddButtonTapped() {
        view.openIncomesDialog()
    }
    
    func handleUpdateIncomeList(incomes: [IncomeDB]) {
        dataManagerService.uploadToRepo(incomes, completion: nil)
        guard let isInternetConnected = reachability?.connection, isInternetConnected != .unavailable else {
            return
        }
        api.sendIncomes(incomes)
        self.incomes.append(contentsOf: incomes)
        makeDatesDictionary()
        view.setIncomes(incomes: datesDictionary)
    }
    
}
