import Foundation

class GraphicsPresenter {

    unowned var view: GraphicsViewProtocol
    unowned var navigator: SceneNavigatorProtocol
    var dataManagerService: DataManagerServiceProtocol
    var currencyService: CurrencyServiceProtocol
    init(view: GraphicsViewProtocol,
         navigator: SceneNavigatorProtocol,
         dataManagerService: DataManagerServiceProtocol,
         currencyService: CurrencyServiceProtocol) {
        
        self.view = view
        self.navigator = navigator
        self.dataManagerService = dataManagerService
        self.currencyService = currencyService
    }
    
    private func getIncomes() -> Float {
        let defCurrency = UserDefaults.standard.string(forKey: AppConstants.defCurrency)
        var sum: Float = 0.0
        let incomes = dataManagerService.getIncomes(for: Date())
        incomes.forEach { element in
            guard let income = element.value,
                let value = income.toFloat() else {
                return
            }
            guard let defCur = defCurrency,
                let cur = element.currency else {return}
            if defCur == cur {
               sum += value
            } else {
              sum += currencyService.convert(from: Currency.init(from: cur), to: Currency.init(from: defCur), value: value)
            }
        }
        return sum
    }
    
    private func getExpenses() -> Float {
        let defCurrency = UserDefaults.standard.string(forKey: AppConstants.defCurrency)
        var sum: Float = 0.0
        let expenses = dataManagerService.getExpenses(for: Date())
        expenses.forEach { element in
           guard let income = element.value,
               let value = income.toFloat() else {
               return
           }
            guard let defCur = defCurrency,
              let cur = element.currency else {return}
            if defCur == cur {
             sum += value
            } else {
            sum += currencyService.convert(from: Currency.init(from: cur), to: Currency.init(from: defCur), value: value)
            }
        }
        return sum
    }
}

// MARK: - SplashPresenterProtocol

extension GraphicsPresenter: GraphicsPresenterProtocol {
    func handleSettingsChoosed(dataType: DataType, sumType: SumType, period: TimePeriod) {
        switch sumType {
        case .day:
            view.setChartData(dataManagerService.getDayExpensesFor(period: period), for: .day)
        case .month:
            dataType == DataType.expenses ?
            view.setChartData(dataManagerService.getMonthExpensesFor(period: period), for: .month)
            : view.setChartData(dataManagerService.getMonthIncomesFor(period: period), for: .month)
        case .category:
             dataType == DataType.expenses ?
            view.setChartData(dataManagerService.getCategoryExpensesFor(period: period), for: .category)
            : view.setChartData(dataManagerService.getCategoryIncomesFor(period: period), for: .category)
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
