import Foundation

class GraphicsPresenter {

    unowned var view: GraphicsViewProtocol
    unowned var navigator: SceneNavigatorProtocol
    var dataManagerService: DataManagerServiceProtocol
    
    init(view: GraphicsViewProtocol,
         navigator: SceneNavigatorProtocol,
         dataManagerService: DataManagerServiceProtocol) {
        
        self.view = view
        self.navigator = navigator
        self.dataManagerService = dataManagerService
    }
    
    private func getIncomes() -> Float {
        var sum: Float = 0.0
        let incomes = dataManagerService.getIncomes(for: Date())
        incomes.forEach { element in
            guard let income = element.income,
                let intValue = income.toFloat() else {
                return
            }
            sum += intValue
        }
        return sum
    }
    
    private func getExpenses() -> Float {
        var sum: Float = 0.0
        let expenses = dataManagerService.getExpenses(for: Date())
        expenses.forEach { element in
           guard let income = element.cost,
               let intValue = income.toFloat() else {
               return
           }
           sum += intValue
        }
        return sum
    }
}

// MARK: - SplashPresenterProtocol

extension GraphicsPresenter: GraphicsPresenterProtocol {
    func handleSettingsChoosed(sumType: SumType, period: TimePeriod) {
        switch sumType {
        case .day:
            view.setChartData(dataManagerService.getDayExpensesFor(period: period), for: .day)
        case .month:
            view.setChartData(dataManagerService.getMonthExpensesFor(period: period), for: .month)
        case .category:
            view.setChartData(dataManagerService.getCategoryExpensesFor(period: period), for: .category)
        }
    }
    
    func handleViewWillAppear() {
        view.setProgress(incomes: getIncomes(), expenses: getExpenses())
        view.setChartData(dataManagerService.getDayExpensesFor(period: .week), for: .day)
    }
}

extension String {
    func toFloat() -> Float? {
        guard let value = Float(self) else {
            return nil
        }
        return value
    }
}
