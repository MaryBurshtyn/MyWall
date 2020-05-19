import Foundation

protocol GraphicsViewProtocol: class {
    func setProgress(incomes: Float, expenses: Float)
    func setChartData(_ data: [(key: String, value: Float)], for sumType: SumType)
}
