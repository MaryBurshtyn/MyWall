import Foundation

protocol IncomePresenterProtocol: class {
    func handleViewDidLoad()
    func handleAddButtonTapped()
    func handleUpdateIncomeList(incomes: [IncomeDB])
}
