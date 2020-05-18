import Foundation

protocol CostViewProtocol: class {
    func setCosts(costs: [(key: String, value: [CostDB])])
    func openExpensesDialog()
    func showPreloader()
    func hidePreloader()
}
