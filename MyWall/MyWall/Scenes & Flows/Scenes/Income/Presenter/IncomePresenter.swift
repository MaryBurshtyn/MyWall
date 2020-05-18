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
}

// MARK: - SplashPresenterProtocol

extension IncomePresenter: IncomePresenterProtocol {
    func handleViewDidLoad() {
        view.showPreloader()
        incomes = self.dataManagerService.getAllIncomes()
        incomes = incomes.sorted(by: {
            guard let fDate = $0.date, let sDate = $1.date else {
                return false
            }
            return fDate.compare(sDate) == .orderedAscending
        })
        makeDatesDictionary()
        self.view.setIncomes(incomes: datesDictionary) 
        self.view.hidePreloader()
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
