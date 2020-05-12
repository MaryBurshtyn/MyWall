import Foundation
import Reachability

class CostPresenter {

    unowned var view: CostViewProtocol
    unowned var navigator: SceneNavigatorProtocol
    var dataManagerService: DataManagerServiceProtocol
    var reachability: Reachability?
    var costs = [CostDB]()
    
    init(view: CostViewProtocol,
         navigator: SceneNavigatorProtocol,
         dataManagerService: DataManagerServiceProtocol,
         reachability: Reachability?) {
        
        self.view = view
        self.navigator = navigator
        self.dataManagerService = dataManagerService
        self.reachability = reachability
    }
}

// MARK: - CostPresenterProtocol

extension CostPresenter: CostPresenterProtocol {
    func handleAddButtonTapped() {
        view.openExpensesDialog()
    }
    
    func handleViewDidLoad() {
        costs = dataManagerService.getAllExpenses()
        costs = costs.sorted(by: {
            guard let fDate = $0.date, let sDate = $1.date else {
                return false
            }
            return fDate.compare(sDate) == .orderedAscending
        })
        view.setCosts(costs: costs)
    }
    
    func handleUpdateExpensesList(expenses: [CostDB]) {
        guard let isInternetConnected = reachability?.connection, isInternetConnected != .unavailable else {
            dataManagerService.uploadToRepo(expenses, completion: nil)
            return
        }
        //upload to firebase
    }
}
