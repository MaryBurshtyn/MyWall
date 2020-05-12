import Foundation

protocol CostPresenterProtocol: class {
    func handleViewDidLoad()
    func handleAddButtonTapped()
    func handleUpdateExpensesList(expenses: [CostDB])
}
