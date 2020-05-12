import Foundation

protocol ServiceFactoryProtocol {
    func getUserDefaultsService() -> UserDefaultsServiceProtocol
    func getDataManagerService() -> DataManagerServiceProtocol
}
