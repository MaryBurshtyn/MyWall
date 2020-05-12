import Foundation

protocol CostViewProtocol: class {
    func setCosts(costs: [CostDB])
    func openExpensesDialog()
}
