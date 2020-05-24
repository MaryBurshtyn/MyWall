import Foundation

protocol GraphicsPresenterProtocol: class {
    func handleViewWillAppear()
    func handleSettingsChoosed(dataType: DataType, sumType: SumType, period: TimePeriod)
}
