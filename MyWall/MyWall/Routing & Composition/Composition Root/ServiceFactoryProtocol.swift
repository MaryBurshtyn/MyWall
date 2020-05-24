import Foundation

protocol ServiceFactoryProtocol {
    func getDataManagerService() -> DataManagerServiceProtocol
    func getFirebaseService() -> ApiProtocol
    func getCurrencyService() -> CurrencyServiceProtocol
}
