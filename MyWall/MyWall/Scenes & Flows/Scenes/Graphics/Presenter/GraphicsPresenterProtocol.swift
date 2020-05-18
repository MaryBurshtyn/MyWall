import Foundation

protocol GraphicsPresenterProtocol: class {
    func handleViewWillAppear()
    func handleSettingsChoosed(sumType: SumType, period: TimePeriod)
}
