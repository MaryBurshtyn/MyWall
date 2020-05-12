import Foundation

protocol DataManagerServiceProtocol {
    func deleteExpenses(_ items: [CostDB])
    func deleteIncomes(_ items: [IncomeDB])
    func uploadToRepo(_ data: [CostDB], completion: CallBack?)
    func uploadToRepo(_ data: [IncomeDB], completion: CallBack?)
    func getAllExpenses() -> [CostDB]
    func getAllIncomes() -> [IncomeDB]
    func deleteAllItems()
}
