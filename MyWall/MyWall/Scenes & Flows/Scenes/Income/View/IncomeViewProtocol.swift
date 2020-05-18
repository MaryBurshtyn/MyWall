import Foundation

protocol IncomeViewProtocol: class {
    func setIncomes(incomes: [(key: String, value: [IncomeDB])])
    func openIncomesDialog()
    func showPreloader()
    func hidePreloader()
}
